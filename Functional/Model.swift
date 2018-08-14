//
//  Model.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/2/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation

//MARK: - Supplies
var supplies = ["beef", "pork", "chicken"]
let suppliesFunctional = ["beef", "pork", "chicken"]

//MARK: - Cooking functions
func clean(_ supply:String) -> String {
    return supply + "->" + "cleaned"
}
func seasoning(_ supply:String) -> String {
    return supply + "->" + "seasoning"
}
func grill(_ supply:String) -> String {
    return supply + "->" + "grilled"
}
func printSupply (_ supply: String){
    print(supply)
}

