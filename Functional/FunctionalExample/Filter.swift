//
//  Functional4.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/4/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation

class Functional4 : Example {
    func example() {
        
        func biggerThanFive(_ number:Int) -> Bool {
            if (number > 5) { return true }
            return false
        }
        
        func isOdd(number:Int) -> Bool {
            if (number%2 == 1) { return true }
            return false
        }
        
        let numbers = [1,2,3,4,5,6,7,8,9]
        let filteredArray = numbers.filter(isOdd)
        filteredArray.forEach{print($0)}
    }
}

extension Array {

//    func myTestFilter(_ isIncluded: (Element) -> Bool) -> [Element] {
//        var filterdArray = [Element]()
//        //code
//
//        return filterdArray
//    }
}

