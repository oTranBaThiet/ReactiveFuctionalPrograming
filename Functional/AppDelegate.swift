//
//  AppDelegate.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 7/31/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        examples.forEach(runExample)
        return true
    }
}

//MARK: - Examples
let examples = [Functional4()]
func runExample(_ ex:Example){
    ex.example()
}
func printSeparator(_ subject:String){
    print(String(format: "*************************** %@ ***************************",subject))
}
func printCachCu(){printSeparator("Cách cũ")}
func printFunctional(){printSeparator("Kiểu Functional")}
func printTrailingClosure(){printSeparator("Kiểu Functional sử dụng Trailing Closure")}
extension Array {
    func myFilter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var filterdArray = [Element]()
        for item in self {
            if isIncluded(item) {
                filterdArray.append(item)
            }
        }
        return filterdArray
    }
}
