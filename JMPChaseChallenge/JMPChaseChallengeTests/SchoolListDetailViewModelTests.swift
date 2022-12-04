//
//  SchoolListDetailViewModelTests.swift
//  JMPChaseChallengeTests
//
//  Created by Yangbin Wen on 12/4/22.
//

import XCTest
@testable import JMPChaseChallenge

final class SchoolListDetailViewModelTests: XCTestCase {

    private var viewModel: SchoolListDetailViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = .init(schoolModel: .init())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testViewModelSetup() throws {
        XCTAssertEqual(viewModel.schoolName, "N/A")
        XCTAssertEqual(viewModel.numberOfTesters, "N/A")
        XCTAssertEqual(viewModel.mathAvg, "N/A")
        XCTAssertEqual(viewModel.readingAvg, "N/A")
        XCTAssertEqual(viewModel.writingAvg, "N/A")
    }

}
