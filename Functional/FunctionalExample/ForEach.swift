//
//  Functional1.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/2/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation

class Functional1 : Example {
    func example() {
        
        
        printCachCu()
        /******************** Cách cũ ***********************/
        for  item in supplies {
            print(item)
        }
        /*******************************************/
        
        
        printFunctional()
        /*************************** Kiểu Functional ***************************/
        suppliesFunctional.myForEach(printSupply)
        /*******************************************/
        
        
        printTrailingClosure()
        /*************************** Kiểu Functional sử dụng Trailing Closure ***************************/
        suppliesFunctional.myForEach { (supply) in
            print(supply)
        }
        /*******************************************/
    }
}

extension Array {
    
    func myForEach(_ body: (Element)  -> Void) {
        for item in self {
            body(item)
        }
    }
    
    
//    func myForEach(_ applyfunction: (Element)->Void){
//        for item in self {
//            applyfunction(item)
//        }
//    }
}
