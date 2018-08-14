//
//  Functional3.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/4/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation

class Functional3 : Example {
    func example() {
        
        printCachCu()
        /*************************** Cách cũ ***************************/
        var cleanedSupplies = [String]()
        for item in supplies {
            let cleanedItem = clean(item)
            cleanedSupplies.append(cleanedItem)
        }
        
        var cleanedSeasonedSupplies = [String]()
        for item in cleanedSupplies {
            let cleanedSupplies = seasoning(item)
            cleanedSeasonedSupplies.append(cleanedSupplies)
        }
        var cleanedSeasonedGrillSupplies = [String]()
        for item in cleanedSeasonedSupplies {
            let cleanedSeasonedSupplies = grill(item)
            cleanedSeasonedGrillSupplies.append(cleanedSeasonedSupplies)
        }
        cleanedSeasonedGrillSupplies.forEach(printSupply)
        /*******************************************/
        
        printFunctional()
        /*************************** Kiểu Functional ***************************/
        let cleanedSeasonedGrillSuppliesFunctional = suppliesFunctional.map(clean).map(seasoning).map(grill)
        cleanedSeasonedGrillSuppliesFunctional.forEach(printSupply)
        /*******************************************/
        
        
        printTrailingClosure()
        /*************************** Kiểu Functional sử dụng Trailing Closure ***************************/
        let cleanedSeasonedGrillSuppliesTrailingClosure = suppliesFunctional.map { (supply) -> String in
            clean(supply)
            }.map { (cleanedSupply) -> String in
                seasoning(cleanedSupply)
            }.map { (cleanedSeasonedSupply) -> String in
                grill(cleanedSeasonedSupply)
        }
        cleanedSeasonedGrillSuppliesTrailingClosure.forEach(printSupply)
        /*******************************************/
    }
}
