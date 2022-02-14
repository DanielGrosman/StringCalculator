//
//  StringCalculatorTests.swift
//  StringCalculatorTests
//
//  Created by Danny Grosman on 2022-02-13.
//

import XCTest
@testable import StringCalculator

class StringCalculatorTests: XCTestCase {
    var sut = StringCalculator()
    
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {}
    
    // Requirement #1(a) - empty strings should return 0
    func testAdd_emptyString() throws {
        let emptyString = ""
        let expectedResult = 0

        do {
            let result = try sut.add(emptyString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected result to be 0 with an empty input string, but got error")
        }
    }
    
    // Requirement #1(b) - comma separated strings should return the sum of the numbers
    func testAdd_commaSeparatedString() throws {
        let commaSeparatedString = "1,2,5"
        let expectedResult = 8

        do {
            let result = try sut.add(commaSeparatedString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected result to be 8 with an input string of `1,2,5`, but got error")
        }
    }

    // Requirement #2 - support new lines in the input format
    func testAdd_newLine() throws {
        let newLineString1 = "1\n,2,3"
        let newLineString2 = "1,\n2,4"
        
        let expectedResult1 = 6
        let expectedResult2 = 7

        do {
            let result1 = try sut.add(newLineString1)
            let result2 = try sut.add(newLineString2)
            
            XCTAssertEqual(result1, expectedResult1)
            XCTAssertEqual(result2, expectedResult2)
        } catch {
            XCTFail("expected result1 to be 6 with an input string of `1\n,2,3`, result2 to be 7 with and input string of `1,\n2,4`, but got an error")
        }
    }
    
    // Requirement #3 - support a custom delimiter
    func testAdd_customDelimiter() throws {
        let customDelimiterString1 = "//$\n1$2$3"
        let customDelimiterString2 = "//@\n2@3@8"
        
        let expectedResult1 = 6
        let expectedResult2 = 13

        do {
            let result1 = try sut.add(customDelimiterString1)
            let result2 = try sut.add(customDelimiterString2)
            
            XCTAssertEqual(result1, expectedResult1)
            XCTAssertEqual(result2, expectedResult2)
        } catch {
            XCTFail("expected result1 to be 6 with an input string of `//$\n1$2$3`, result2 to be 13 with and input string of `//@\n2@3@8`, but got an error")
        }
    }
    
    // Requirement #4 - calling `add` with negative number(s) should throw an error
    func testAdd_negativeNumber() throws {
        let stringWithNegativeNumbers = "1,2,3,-5,-7"
        let expectedNegativeNumbers = [-5,-7]
        
        do {
            let _ = try sut.add(stringWithNegativeNumbers)
        } catch StringCalculator.StringCalculatorError.invalidNegativeNumbers(let negativeNumbers) {
            XCTAssertEqual(negativeNumbers, expectedNegativeNumbers)
        }
    }
    
    // Bonus #1 - numbers larger than 1000 should be ignored
    func testAdd_numberGreaterThan1000() throws {
        let stringWithLargeNumber = "2,1001"
        let expectedResult = 2
        
        do {
            let result = try sut.add(stringWithLargeNumber)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected result to be 2 with an input string of `2,1001`, but got error")
        }
    }
    
    // Bonus #2 - delimiters can be arbitrary length
    func testAdd_arbitraryLengthDelimiter() throws {
        let arbitraryLengthDelimiterString = "//***\n1***2***3"
        let expectedResult = 6
        
        do {
            let result = try sut.add(arbitraryLengthDelimiterString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected result to be 6 with an input string of `//***\n1***2***3`, but got error")
        }
    }
    
    // Bonus #3 - allow for multiple delimiters
    func testAdd_multipleDelimiters() throws {
        let multipleDelimiterString = "//$,@\n1$2@3"
        let expectedResult = 6
        
        do {
            let result = try sut.add(multipleDelimiterString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected result to be 6 with an input string of `//$,@\n1$2@3`, but got error")
        }
    }
    
    // Bonus #4 - allow for multiple delimiters of arbitrary length
    func testAdd_multipleDelimitersArbitraryLength() throws {
        let multipleDelimiterArbitraryLengthString = "//$$$$,@@\n1$$$$4@@3"
        let expectedResult = 8
        
        do {
            let result = try sut.add(multipleDelimiterArbitraryLengthString)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("expected result to be 8 with an input string of `//$$$$,@@\n1$$$$4@@3`, but got error")
        }
    }
}
