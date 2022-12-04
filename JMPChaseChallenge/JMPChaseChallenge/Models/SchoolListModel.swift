//
//  SchoolListModel.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation

struct SchoolListModel: Codable {
    var dbn: String
    var schoolName: String
    var overview: String
    var phoneNumber: String
    var schoolEmail: String
    var totalStudents: String
    
    enum codingKeys: String, CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
        case overview = "overview_paragraph"
        case phoneNumber = "phone_number"
        case schoolEmail = "school_email"
        case totalStudents = "total_students"
    }
    
    init() {
        dbn = "N/A"
        schoolName = "N/A"
        overview = "N/A"
        phoneNumber = "N/A"
        schoolEmail = "N/A"
        totalStudents = "N/A"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        self.dbn = try container.decodeIfPresent(String.self, forKey: .dbn) ?? ""
        self.schoolName = try container.decodeIfPresent(String.self, forKey: .schoolName) ?? ""
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? "N/A"
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? "N/A"
        self.schoolEmail = try container.decodeIfPresent(String.self, forKey: .schoolEmail) ?? "N/A"
        self.totalStudents = try container.decodeIfPresent(String.self, forKey: .totalStudents) ?? "N/A"
    }
}
