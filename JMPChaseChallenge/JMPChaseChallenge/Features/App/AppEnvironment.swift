//
//  AppEnvironment.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation

struct AppEnvironment {
    let schoolApiClient: SchoolApiClientProtocal
    let requestProvider: RequestProvider
    
    init(schoolApiClient: SchoolApiClientProtocal, requestProvider: RequestProvider) {
        self.schoolApiClient = schoolApiClient
        self.requestProvider = requestProvider
    }
}
