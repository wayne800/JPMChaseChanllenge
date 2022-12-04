//
//  RequestProvider.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation

protocol ApiProviderCapabilities {
    // Requests for Schools feature
    func createRequest(with api: SchoolsApi) -> URLRequest?
}

struct RequestProvider: ApiProviderCapabilities {
    func createRequest(with api: SchoolsApi) -> URLRequest? {
        if let str = api.urlString,
           let url = URL(string: str) {
            var request = URLRequest(url: url)
            request.httpMethod = api.method
            return request
        }
        
        return nil
    }
}
