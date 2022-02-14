//
//  StringCalculatorTests.swift
//  StringCalculatorTests
//
//  Created by Danny Grosman on 2022-02-13.
//

import XCTest
@testable import StringCalculator

class StringCalculatorTests: XCTestCase {
    let sut = StringCalculator()
    
    // Requirement #1(a) - empty strings should return 0
    func testAdd_emptyString() {
        let inputString = ""
        let expectedResult = 0
        
        do {
            let result = try sut.add(inputString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected \(expectedResult) with input \(inputString), got \(error.localizedDescription)")
        }
    }
    
    // Requirement #1(b) - comma separated strings should return the sum of the numbers
    func testAdd_commaSeparatedString() {
        let inputString = "1,2,5"
        let expectedResult = 8
        
        do {
            let result = try sut.add(inputString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected \(expectedResult) with input \(inputString), got \(error.localizedDescription)")
        }
    }
    
    // Requirement #2 - support new lines in the input format
    func testAdd_newLine() {
        let inputString1 = "1\n,2,3"
        let inputString2 = "1,\n2,4"
        
        let expectedResult1 = 6
        let expectedResult2 = 7
        
        do {
            let result1 = try sut.add(inputString1)
            let result2 = try sut.add(inputString2)
            
            XCTAssertEqual(result1, expectedResult1)
            XCTAssertEqual(result2, expectedResult2)
        } catch {
            XCTFail("expected \(expectedResult1) with input \(inputString1) and \(expectedResult2) with input \(inputString2), got \(error.localizedDescription)")
        }
    }
    
    // Requirement #3 - support a custom delimiter
    func testAdd_customDelimiter() {
        let inputString1 = "//$\n1$2$3"
        let inputString2 = "//@\n2@3@8"
        
        let expectedResult1 = 6
        let expectedResult2 = 13
        
        do {
            let result1 = try sut.add(inputString1)
            let result2 = try sut.add(inputString2)
            
            XCTAssertEqual(result1, expectedResult1)
            XCTAssertEqual(result2, expectedResult2)
        } catch {
            XCTFail("expected \(expectedResult1) with input \(inputString1) and \(expectedResult2) with input \(inputString2), got \(error.localizedDescription)")
        }
    }
    
    // Requirement #4 - calling `add` with negative number(s) should throw an error
    func testAdd_negativeNumber() throws {
        let inputString = "1,2,3,-5,-7"
        let expectedNegativeNumbers = [-5,-7]
        
        do {
            let _ = try sut.add(inputString)
        } catch StringCalculator.StringCalculatorError.invalidNegativeNumbers(let negativeNumbers) {
            XCTAssertEqual(negativeNumbers, expectedNegativeNumbers)
        }
    }
    
    // Bonus #1 - numbers larger than 1000 should be ignored
    func testAdd_numberGreaterThan1000() {
        let inputString = "2,1001"
        let expectedResult = 2
        
        do {
            let result = try sut.add(inputString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected \(expectedResult) with input \(inputString), got \(error.localizedDescription)")
        }
    }
    
    // Bonus #2 - delimiters can be arbitrary length
    func testAdd_arbitraryLengthDelimiter() {
        let inputString = "//***\n1***2***3"
        let expectedResult = 6
        
        do {
            let result = try sut.add(inputString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected \(expectedResult) with input \(inputString), got \(error.localizedDescription)")
        }
    }
    
    // Bonus #3 - allow for multiple delimiters
    func testAdd_multipleDelimiters() {
        let inputString = "//$,@\n1$2@3"
        let expectedResult = 6
        
        do {
            let result = try sut.add(inputString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected \(expectedResult) with input \(inputString), got \(error.localizedDescription)")
        }
    }
    
    // Bonus #4 - allow for multiple delimiters of arbitrary length
    func testAdd_multipleDelimitersArbitraryLength() {
        let inputString = "//$$$$,@@\n1$$$$4@@3"
        let expectedResult = 8
        
        do {
            let result = try sut.add(inputString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected \(expectedResult) with input \(inputString), got \(error.localizedDescription)")
        }
    }
}
