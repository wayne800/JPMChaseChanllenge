//
//  SchoolListDetailModel.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation

struct SchoolListDetailModel: Codable {
    var dbn: String
    var schoolName: String
    var numOfSatTakers: String
    var readingAvg: String
    var mathAvg: String
    var writingAbg: String
    
    enum SchoolDetailCodingKeys: String, CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
        case numOfSatTakers = "num_of_sat_test_takers"
        case readingAvg = "sat_critical_reading_avg_score"
        case mathAvg = "sat_math_avg_score"
        case writingAvg = "sat_writing_avg_score"
    }
    
    init() {
        self.dbn = "N/A"
        self.schoolName = "N/A"
        self.numOfSatTakers = "N/A"
        self.readingAvg = "N/A"
        self.mathAvg = "N/A"
        self.writingAbg = "N/A"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SchoolDetailCodingKeys.self)
        self.dbn = try container.decodeIfPresent(String.self, forKey: .dbn) ?? "N/A"
        self.schoolName = try container.decodeIfPresent(String.self, forKey: .schoolName) ?? "N/A"
        self.numOfSatTakers = try container.decodeIfPresent(String.self, forKey: .numOfSatTakers) ?? "N/A"
        self.readingAvg = try container.decodeIfPresent(String.self, forKey: .readingAvg) ?? "N/A"
        self.mathAvg = try container.decodeIfPresent(String.self, forKey: .mathAvg) ?? "N/A"
        self.writingAbg = try container.decodeIfPresent(String.self, forKey: .writingAvg) ?? "N/A"
    }
}
