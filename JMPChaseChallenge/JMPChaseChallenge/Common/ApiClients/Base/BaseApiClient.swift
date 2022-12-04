//
//  BaseApiClient.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Combine
import Foundation

enum ErrorType: Error {
    case apiError
    case serverError
    case decodeError
    case noData
}

protocol ApiServiceProviderProtocal {
    func sessionDataTask(with request: URLRequest) -> AnyPublisher<Data, ErrorType>
}

final class BaseApiClient: ApiServiceProviderProtocal {
    // MARK: private properties
    
    private let urlSession = URLSession.shared
    
    // MARK: pulibc interface
    
    static let shared = BaseApiClient()
    
    // MARK: Initialization
    
    init() {}
    
    // MARK: ApiServiceProviderProtocal
    
    func sessionDataTask(with request: URLRequest) -> AnyPublisher<Data, ErrorType> {
        return Future<Data, ErrorType> {[weak self] promise in
            let task = self?.urlSession.dataTask(with: request) { data, response, error in
                if let response = response as? HTTPURLResponse,
                    !(200...299).contains(response.statusCode) {
                    if (400...499).contains(response.statusCode) {
                        promise(.failure(.apiError))
                    }
                    if (500...599).contains(response.statusCode) {
                        promise(.failure(.serverError))
                    }
                }
                
                if let data = data {
                    promise(.success(data))
                } else {
                    promise(.failure(.noData))
                }
            }
            
            task?.resume()
        }
        .eraseToAnyPublisher()
    }
}
