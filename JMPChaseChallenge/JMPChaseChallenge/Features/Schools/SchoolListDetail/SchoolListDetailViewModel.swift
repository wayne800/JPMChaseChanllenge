//
//  SchoolListDetailViewModel.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import SwiftUI

final class SchoolListDetailViewModel: ObservableObject {
    // MARK: private properties
    private let schoolModel: SchoolListDetailModel
    
    // MARK: SchoolListDetailViewModelOutput
    @Published var schoolName = ""
    @Published var numberOfTesters = ""
    @Published var readingAvg = ""
    @Published var mathAvg = ""
    @Published var writingAvg = ""
    
    // MARK: Initialization
    init(schoolModel: SchoolListDetailModel) {
        self.schoolModel = schoolModel
        schoolName = schoolModel.schoolName
        numberOfTesters = schoolModel.numOfSatTakers
        readingAvg = schoolModel.readingAvg
        mathAvg = schoolModel.mathAvg
        writingAvg = schoolModel.writingAbg
    }
}
