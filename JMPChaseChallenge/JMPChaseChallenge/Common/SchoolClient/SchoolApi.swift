//
//  SchoolApi.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation

enum SchoolsApi {
    case schoolList
    case schoolDetails
    
    var baseURL: String {
        "https://data.cityofnewyork.us"
    }
    
    var method: String {
        switch self {
        case .schoolList, .schoolDetails:
            return "GET"
        }
    }
    
    var urlString: String? {
        switch self{
        case .schoolList:
            return "\(baseURL)/resource/s3k6-pzi2.json"
        case .schoolDetails:
            return "\(baseURL)/resource/f9bf-2cp4.json"
        }
    }
}
