import Foundation

/**
 * Created by Val I on 2025-04-21
 * Version 1.0
 * Copyright (c) 2025 Val I. All rights reserved.
 *
 * The Exponent program reads an int from a file
 * and finds the exponent using recursion.
 *
 */

enum TypeError: Error {
    case invalidInput
}
// This function calculates exponent using recursion.
func exponent(_ base: Int, _ exp: Int) -> Int {
    if exp == 0 {
        return 1
    } else {
        return base * exponent(base, exp - 1)
    }
}

// File paths
let inputFilePath = "./input.txt"
let outputFilePath = "./output.txt"

// Open the input file for reading
guard let input = FileHandle(forReadingAtPath: inputFilePath) else {
    print("Error: can't find input file")
    exit(1)
}

// Open the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFilePath) else {
    print("Error: can't open output file")
    exit(1)
}

// Read the contents of the input file
let inputData = input.readDataToEndOfFile()

// Convert the data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: can't convert input data to string")
    exit(1)
}

// Split the string into lines
let inputLines = inputString.components(separatedBy: .newlines)

// Process each line
for line in inputLines {
    if !line.isEmpty {
        do {
            // seperate the line into words
            let words = line.components(separatedBy: " ")
            // Check if the line contains 2 words
            if words.count != 2 {
                let errorMessage = "provide two integers.\n"
                output.write(errorMessage.data(using: .utf8)!)
            } else {
                // Try to cast the line to an integer
                if let number = Int(words[0]), let exponentNum = Int(words[1]) {
                    if exponentNum < 0 {
                        let warningMessage = "Exponent can't be negative.\n"
                        output.write(warningMessage.data(using: .utf8)!)
                    } else {
                        // Calculate the exponent of the number
                        let exponentResult = exponent(number, exponentNum)
                        let message = "\(exponentResult)\n"
                        output.write(message.data(using: .utf8)!)
                    }
                } else {
                    throw TypeError.invalidInput
                }
            }
        } catch TypeError.invalidInput {
            let errorMessage = "Provide integers.\n"
            output.write(errorMessage.data(using: .utf8)!)
        
        }

    }
}

// Close the input and output files
input.closeFile()
output.closeFile()