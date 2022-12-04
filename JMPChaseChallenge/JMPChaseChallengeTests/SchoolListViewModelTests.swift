//
//  JMPChaseChallengeTests.swift
//  JMPChaseChallengeTests
//
//  Created by Yangbin Wen on 12/3/22.
//

import XCTest
import Combine
@testable import JMPChaseChallenge

final class SchoolListViewModelTests: XCTestCase {
    private var viewModel: SchoolListViewModel!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = .init(schoolsApiClient: MockSchoolApiClient(), requestProvider: .init())
        cancellables = .init()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        cancellables = nil
    }

    func testFetchSchools() throws {
        viewModel.fetchShools()
        
        viewModel.outputs.schoolsItems
            .dropFirst() // Skip the default value
            .sink { _ in } receiveValue: { models in
                XCTAssertEqual(models.count, 3)
                let name = models.map { model in
                    model.schoolName
                }
                XCTAssertEqual(name, ["Clinton School Writers & Artists, M.S. 260",
                                     "Liberation Diploma Plus High School",
                                     "Women's Academy of Excellence"])
            }
            .store(in: &cancellables)
    }
    
    func testSelectSchoolDetail() {
        
        viewModel.outputs.schoolsDetailItem
            .sink { _ in } receiveValue: { model in
                XCTAssertEqual(model.schoolName, "Liberation Diploma Plus High School")
                XCTAssertEqual(model.writingAbg, "366")
                XCTAssertEqual(model.readingAvg, "383")
                XCTAssertEqual(model.mathAvg, "423")
            }
            .store(in: &cancellables)
        
        viewModel.selected(with: IndexPath(row: 1, section: 0))
    }

}

