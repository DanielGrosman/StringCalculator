//
//  StringCalculator.swift
//  StringCalculator
//
//  Created by Danny Grosman on 2022-02-13.
//

import UIKit

struct StringCalculator {
    let controlCode = "//"
    let defaultDelimiter = ","

    enum StringCalculatorError: Error, Equatable {
        case invalidNegativeNumbers(_ negativeNumbers: [Int])
    }

    func add(_ numbers: String) throws -> Int {
        guard !numbers.isEmpty else { return 0 }
        
        var delimiters: CharacterSet = .init(charactersIn: defaultDelimiter)
        
        // if the string start with control code, update the `delimiters` character set to include any custom delimiters
        if numbers.starts(with: controlCode) {
            if let delimiterValue = numbers.split(separator: "\n").first { // separate 
                let newDelimiterValue = delimiterValue.dropFirst(2) // remove the control code in front of the delimiter(s)
                delimiters = CharacterSet.init(charactersIn: String(newDelimiterValue))
            }
        }
        
        // remove the newline code from the string
        // convert the string to an array of integers
        // remove any values that are > 1000
        let intArray = numbers.components(separatedBy: .newlines).joined()
            .components(separatedBy: delimiters).compactMap { Int($0) }
            .filter { $0 <= 1000 }
        
        
        // throw an error if there are any negative numbers in the array
        let negativeNumbers = intArray.filter { $0 < 1 }
        if !negativeNumbers.isEmpty {
            throw StringCalculatorError.invalidNegativeNumbers(negativeNumbers)
        }
        
        // return the sum of all the integers
        return intArray.reduce(0, +)
    }
}

