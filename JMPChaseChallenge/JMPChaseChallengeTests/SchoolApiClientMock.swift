//
//  SchoolApiClientMock.swift
//  JMPChaseChallengeTests
//
//  Created by Yangbin Wen on 12/4/22.
//

import Combine
import Foundation
@testable import JMPChaseChallenge

final class MockSchoolApiClient: SchoolApiClientProtocal {
    private let schoolListSubject: PassthroughSubject<Result<[SchoolListModel], ErrorType>, ErrorType>
    private let schoolListDetilasSubject: PassthroughSubject<Result<[SchoolListDetailModel], ErrorType>, ErrorType>
    private var cancellables: Set<AnyCancellable>
    
    var schoolListPublisher: AnyPublisher<Result<[SchoolListModel], ErrorType>, ErrorType> {
        schoolListSubject.eraseToAnyPublisher()
    }
    
    var schoolListDetailsPublisher: AnyPublisher<Result<[SchoolListDetailModel], ErrorType>, ErrorType> {
        schoolListDetilasSubject.eraseToAnyPublisher()
    }
    
    init() {
        self.schoolListSubject = .init()
        self.schoolListDetilasSubject = .init()
        cancellables = .init()
    }
    
    func fetchSchoolList(with schoolRequest: URLRequest?, _ decoder: ObjectDecoder) {
        guard let pathString = Bundle(for: SchoolListViewModelTests.self).path(forResource: "SchoolsMock", ofType: "json") else {
            fatalError("SchoolsMock.json not found")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: pathString), options: .mappedIfSafe)
            let jsonResult: Result<[SchoolListModel], ErrorType> = decoder.decodeObject(with: data)
            switch jsonResult {
            case .success(let models):
                schoolListSubject.send(.success(models))
            case .failure(let err):
                schoolListSubject.send(.failure(err))
            }
        } catch {
            schoolListSubject.send(.failure(.decodeError))
        }
    }
    
    func fetchSchoolListDetails(with schoolRequest: URLRequest?, _ decoder: ObjectDecoder) {
        
        guard let pathString = Bundle(for: SchoolListViewModelTests.self).path(forResource: "SchoolDetailsMock", ofType: "json") else {
            fatalError("SchoolDetailsMock.json not found")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: pathString))
            let jsonResult: Result<[SchoolListDetailModel], ErrorType> = decoder.decodeObject(with: data)
            switch jsonResult {
            case .success(let models):
                schoolListDetilasSubject.send(.success(models))
            case .failure(let err):
                schoolListDetilasSubject.send(.failure(err))
            }
        } catch {
            schoolListDetilasSubject.send(.failure(.decodeError))
        }
    }
}



