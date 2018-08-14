//
//  Functional5.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/6/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation

class Functional5 :Example {
    func example() {
        let arrayInArray  = [[11,12,13],[14,15,16,17,18,55]]
        let flattêndArray = arrayInArray.myFlatMap{$0}
        flattêndArray.forEach{print($0)}
    }
}

extension Array {
//    func myUnwrap<U>(_ inputArray:[Element], _ apply: ((Element)->U)) -> [U] {
//        var unwrappedArray = [U]()
//        for item in inputArray {
//            let unwrappedItem = apply(item)
//            unwrappedArray.append(unwrappedItem)
//        }
//        return unwrappedArray
//    }
//    func myFlat<U>(_ input: [[U]]) -> [U] {
//        var flatArray = [U]()
//        for partialArry in input {
//            for item in partialArry {
//                flatArray.append(item)
//            }
//        }
//        return flatArray
//    }
//    func myThen<U>(_ fn:((Element) -> U)) -> [U] {
//        return myUnwrap(self, fn)
//    }
//    func myFlatMap<U>(_ fn: ((Element) -> [U])) -> [U] {
//        let apply = myThen(fn)
//        return myFlat(apply)
//    }
    func myUnwrap<U>(_ inputArray:[Element], _ apply: ((Element)->U)) -> [U] {
        var unwrappedArray = [U]()
        for item in inputArray {
            let unwrappedItem = apply(item)
            unwrappedArray.append(unwrappedItem)
        }
        return unwrappedArray
    }
    func myFlat<U>(_ input: [[U]]) -> [U] {
        var flatArray = [U]()
        for partialArry in input {
            for item in partialArry {
                flatArray.append(item)
            }
        }
        return flatArray
    }
    func myThen<U>(_ fn:((Element) -> U)) -> [U] {
        return myUnwrap(self, fn)
    }
    func myFlatMap<U>(_ fn: ((Element) -> [U])) -> [U] {
        return myFlat(myUnwrap(self, fn))
    }
}
