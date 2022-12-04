//
//  SchoolListViewModel.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Combine
import Foundation

protocol SchoolListViewModelOutputs {
    var schoolsItems: AnyPublisher<[SchoolListModel], ErrorType> { get }
    var schoolsDetailItem: AnyPublisher<SchoolListDetailModel, ErrorType> { get }
    var isLoadingData: AnyPublisher<Bool, Never> { get }
    var errorInfo: AnyPublisher<ErrorType, Never> { get }
}
protocol SchoolListViewModelInputs{
    func fetchShools()
    func selected(with indexPath: IndexPath)
}

protocol SchoolListViewModelType: SchoolListViewModelInputs, SchoolListViewModelOutputs {
    var inputs: SchoolListViewModelInputs { get }
    var outputs: SchoolListViewModelOutputs { get }
}

final class SchoolListViewModel: SchoolListViewModelInputs, SchoolListViewModelOutputs {
    
    //MARK: private properties
    
    private let schoolsApiClient: SchoolApiClientProtocal
    private let requestProvider: RequestProvider
    private let isLoadingSubject: PassthroughSubject<Bool, Never>
    private let schoolItemsSubject: CurrentValueSubject<[SchoolListModel], ErrorType>
    private let selectedSchoolItemSubject: PassthroughSubject<SchoolListDetailModel, ErrorType>
    private let errorSubject: PassthroughSubject<ErrorType, Never>
    private(set) var schoolsDetailItems: [String: SchoolListDetailModel]
    private var selectedIndexPath: IndexPath?
    private var cancellables: Set<AnyCancellable>
    
    //MARK: SchoolListViewModelOutputs
    
    var schoolsItems: AnyPublisher<[SchoolListModel], ErrorType> {
        schoolItemsSubject.eraseToAnyPublisher()
    }
    
    var schoolsDetailItem: AnyPublisher<SchoolListDetailModel, ErrorType> {
        selectedSchoolItemSubject.eraseToAnyPublisher()
    }
    
    var isLoadingData: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }
     
    var errorInfo: AnyPublisher<ErrorType, Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    //MARK: Initialization
    
    init(schoolsApiClient: SchoolApiClientProtocal, requestProvider: RequestProvider) {
        self.schoolsApiClient = schoolsApiClient
        self.requestProvider = requestProvider
        self.isLoadingSubject = .init()
        self.schoolsDetailItems = [:]
        self.schoolItemsSubject = .init([])
        self.selectedSchoolItemSubject = .init()
        self.errorSubject = .init()
        self.cancellables = []
        setupObservers()
    }
    
    private func setupObservers() {
        schoolsApiClient.schoolListPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] events in
                switch events {
                case .failure(let err):
                    self?.errorSubject.send(err)
                default:
                    print("schoolListPublisher completed")
                }
                self?.isLoadingSubject.send(false)
            }, receiveValue: {[weak self] rst in
                switch rst {
                case .success(let models):
                    self?.schoolItemsSubject.send(models)
                case .failure(let err):
                    self?.errorSubject.send(err)
                }
                self?.isLoadingSubject.send(false)
            })
            .store(in: &cancellables)
        
        schoolsApiClient.schoolListDetailsPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] events in
                switch events {
                case .failure(let err):
                    self?.errorSubject.send(err)
                default:
                    print("schoolListDetailPublisher completed")
                }
                self?.isLoadingSubject.send(false)
            } receiveValue: {[weak self] rst in
                switch rst {
                case .success(let models):
                    for model in models {
                        self?.schoolsDetailItems[model.dbn] = model
                    }
                    self?.isLoadingSubject.send(false)
                    if let seletedIndexPath = self?.selectedIndexPath {
                        self?.selected(with: seletedIndexPath)
                    }
                case .failure(let err):
                    self?.errorSubject.send(err)
                }
            }
            .store(in: &cancellables)
    }
}

//MARK: SchoolListViewModelInputs

extension SchoolListViewModel {
    func fetchShools() {
        isLoadingSubject.send(true)
        let request = requestProvider.createRequest(with: .schoolList)
        schoolsApiClient.fetchSchoolList(with: request, .init())
    }
    
    func selected(with indexPath: IndexPath) {
        selectedIndexPath = indexPath
        if schoolsDetailItems.isEmpty {
            isLoadingSubject.send(true)
            setupObservers()
            let request = requestProvider.createRequest(with: .schoolDetails)
            schoolsApiClient.fetchSchoolListDetails(with: request, .init())
        } else {
            let model = schoolItemsSubject.value[indexPath.row]
            selectedSchoolItemSubject.send(schoolsDetailItems[model.dbn] ?? SchoolListDetailModel())
            selectedIndexPath = nil
        }
    }
}

extension SchoolListViewModel: SchoolListViewModelType {
    var inputs: SchoolListViewModelInputs { self }
    var outputs: SchoolListViewModelOutputs { self }
}

//MARK: TableViewDataProvider

extension SchoolListViewModel: TableViewDataProvider {
    typealias DataObject = SchoolListModel
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return schoolItemsSubject.value.count
    }
    
    func objectAtIndexPath(indexPath: IndexPath) -> DataObject {
        return schoolItemsSubject.value[indexPath.row]
    }
}

