//
//  Functional2.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/2/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation

class Functional2 : Example {
    func example() {
        
        printCachCu()
        /*************************** Cách cũ ***************************/
        var cleanedSupplies = [String]()
        for item in supplies {
            let cleanedItem = clean(item)
            cleanedSupplies.append(cleanedItem)
        }
        cleanedSupplies.forEach(printSupply)
        /*******************************************/
        
        printFunctional()
        /*************************** Kiểu Functional ***************************/
        let cleanedSuppliesFunctional = suppliesFunctional.map(clean)
        cleanedSuppliesFunctional.forEach(printSupply)
        /*******************************************/
        
        
        printTrailingClosure()
        /*************************** Kiểu Functional sử dụng Trailing Closure ***************************/
        let cleanedSuppliesTrailingClosure = suppliesFunctional.map { (supply) -> String in
            clean(supply)
        }
        cleanedSuppliesTrailingClosure.forEach(printSupply)
        /*******************************************/
    }
}

extension Array {

    func myMap<U>(_ applyfunction: ((Element) ->U)) -> [U] {
        var transformArray = [U]()
        for item in self {
            let transformItem = applyfunction(item)
            transformArray.append(transformItem)
        }
        return transformArray
    }
}
