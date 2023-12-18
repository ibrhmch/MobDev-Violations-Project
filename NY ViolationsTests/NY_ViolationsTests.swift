//
//  NY_ViolationsTests.swift
//  NY ViolationsTests
//
//  Created by octopus on 12/18/23.
//

import XCTest
@testable import NY_Violations

final class NY_ViolationsTests: XCTestCase {
    
    func testValidDateString() {
        let dateString = "Wed, 10 Oct 2023 00:00:00 GMT"
        let expectedOutput = "2023-10-10"
        
        let result = getDateFromString(dateString)
        
        XCTAssertEqual(result, expectedOutput, "The getDateFromString function did not correctly format the date.")
    }

    func testInvalidDateString() {
        let invalidDateString = "Invalid Date"
        let expectedFallbackOutput = "2022-01-01"
        
        let result = getDateFromString(invalidDateString)
        
        XCTAssertEqual(result, expectedFallbackOutput, "The getDateFromString function should return fallback date for invalid input.")
    }
}
