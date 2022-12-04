//
//  SchoolApiClient.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Combine
import Foundation

protocol SchoolApiClientProtocal {
    var schoolListPublisher: AnyPublisher<Result<[SchoolListModel], ErrorType>, ErrorType> { get }
    var schoolListDetailsPublisher: AnyPublisher<Result<[SchoolListDetailModel], ErrorType>, ErrorType> { get }
    func fetchSchoolList(with schoolRequest: URLRequest?, _ decoder: ObjectDecoder)
    func fetchSchoolListDetails(with schoolRequest: URLRequest?, _ decoder: ObjectDecoder)
}

class SchoolApiClient {
    // MARK: private properties
    
    private let apiClient: BaseApiClient = .shared
    private let schoolListSubject: PassthroughSubject<Result<[SchoolListModel], ErrorType>, ErrorType>
    private let schoolListDetilasSubject: PassthroughSubject<Result<[SchoolListDetailModel], ErrorType>, ErrorType>
    private var cancellables: Set<AnyCancellable>
    
    // MARK: Properties
    
    var schoolListPublisher: AnyPublisher<Result<[SchoolListModel], ErrorType>, ErrorType> {
        schoolListSubject.eraseToAnyPublisher()
    }
    
    var schoolListDetailsPublisher: AnyPublisher<Result<[SchoolListDetailModel], ErrorType>, ErrorType> {
        schoolListDetilasSubject.eraseToAnyPublisher()
    }
    
    // MARK: initialization
    
    init() {
        self.schoolListSubject = .init()
        self.schoolListDetilasSubject = .init()
        cancellables = .init()
    }
}

// SchoolList Protocal implementation
extension SchoolApiClient: SchoolApiClientProtocal {
    func fetchSchoolList(with schoolRequest: URLRequest?, _ decoder: ObjectDecoder = .init()) {
        if let request = schoolRequest {
            apiClient.sessionDataTask(with: request)
                .sink {[weak self] event in
                    switch event {
                    case .failure(let error):
                        self?.schoolListSubject.send(.failure(error))
                    default:
                        break
                    }
                } receiveValue: {[weak self]  data in
                    let rst: Result<[SchoolListModel], ErrorType> = decoder.decodeObject(with: data)
                    
                    switch rst {
                    case .success(let models):
                        self?.schoolListSubject.send(.success(models))
                    case .failure(let err):
                        self?.schoolListSubject.send(.failure(err))
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    func fetchSchoolListDetails(with schoolRequest: URLRequest?, _ decoder: ObjectDecoder = .init()) {
        if let request = schoolRequest {
            apiClient.sessionDataTask(with: request)
                .sink {[weak self] event in
                    switch event {
                    case .failure(let error):
                        self?.schoolListDetilasSubject.send(.failure(error))
                    default:
                        break
                    }
                } receiveValue: {[weak self]  data in
                    let rst: Result<[SchoolListDetailModel], ErrorType> = decoder.decodeObject(with: data)
                    
                    switch rst {
                    case .success(let models):
                        self?.schoolListDetilasSubject.send(.success(models))
                    case .failure(let err):
                        self?.schoolListDetilasSubject.send(.failure(err))
                    }
                }
                .store(in: &cancellables)
        }
    }
}
