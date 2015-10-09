//
//  main.swift
//  SimpleCalc
//
//  Created by blankens on 10/7/15.
//  Copyright © 2015 Adobe. All rights reserved.
//  Torin Blankensmith
//

import Foundation
import Darwin

func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let result = NSString(data: inputData,
        encoding:NSUTF8StringEncoding) as! String
    return
        result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

func convert(incoming:String) -> Double {
    return Double(incoming)!
}

func factorial(n: Double) -> Double {
    return n == 0 ? 1.0 : n * factorial(n-1)
}

func calculate(num1: Double, op: String, num2: Double) -> Double {
    switch op {
        case "%":
            return num1 % num2
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "*":
            return num1 * num2
        case "/":
            return num1 / num2
        default:
            return DBL_MAX
    }
}

func calculate(op: String, nums: [Double]) -> Double{
    switch op {
        case "avg":
            return average(nums)
        case "count":
                return Double(nums.count)
        case "fact":
            if nums[0] < 0 {
                return DBL_MAX
            } else {
                return factorial(nums[0])
            }
        default:
            return DBL_MAX
    }
}

func average(arr: [Double]) -> Double {
    var average : Double = 0.0
    for num in arr {
        average += num
    }
    return average / Double(arr.count)
}

func main() {
    let inputText = input().characters.split{$0 == " "}.map(String.init)
    var nums: [Double] = []
    for val in inputText {
        nums.append(convert(val))
    }
    
    let op = input()
    if nums.count > 1 {
        let value = calculate(op, nums: nums)
        if value != DBL_MAX {
            print(value)
        } else {
            print("Invalid Input")
        }
    } else {
        let num1 = nums[0]
        let value = calculate(op, nums: nums)
        if value == DBL_MAX {
            let num2 = convert(input())
            let output = calculate(num1, op: op, num2: num2)
            if output != DBL_MAX {
                print(output)
            } else {
                print("Invalid Input")
            }
        } else {
            print(value)
        }
    }
}

main()
