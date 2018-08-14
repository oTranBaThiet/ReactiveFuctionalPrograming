//
//  RxViewController.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/7/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import UIKit

class RxViewController: UIViewController , UITableViewDataSource, UITableViewDelegate,UISearchResultsUpdating {
    var observable = Observable<Int>{_ in return AnonimousDisposable({
        print("fd")
    })}
    @IBOutlet weak var tblView: UITableView!
    let allCities = NSArray(array: ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"])
    
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.black
            controller.searchBar.barTintColor = UIColor.white
            controller.searchBar.backgroundColor = UIColor.clear
            self.tblView.tableHeaderView = controller.searchBar
            return controller
        })()
        self.tblView.reloadData()
        
//        self.observable = Observable<Int> {(observer) -> Disposable in
//            observer.on(event: .next(1))
//            observer.on(event: .next(3))
//            observer.on(event: .next(9))
//            observer.on(event: .completed)
//            return AnonimousDisposable {
//                print("disposed")
//            }
//        }
//        _ = observable.map {return $0 * $0 }.subscribeOnNext {print($0)}
        let myObserable = MyObservable<String> { myObserver -> () in
            myObserver.on(event: .next("pork"))
            myObserver.on(event: .next("beef"))
            myObserver.on(event: .next("chicken"))
        }
        
//        _ = myObserable.subscribeOnNext({ (aString) in
//            print(aString)
//        })
        
//        _ = myObserable.map({ (aString) -> String in
//            return aString + "->cleaned"
//        }).map({ (aString) -> String in
//            return aString + "->seasoned"
//        }).map({ (aString) -> String in
//            return aString + "->grilled"
//        }).subscribe(onNext: { (aString) in
//            print(aString)
//        })
//
        _ = myObserable.map(clean).map(seasoning).map(grill).subscribe(onNext: printSupply)
        
        let helloSequence = Observable.just("cooking supply")
        let subscription = helloSequence.subscribeOnNext { (aString) in
            print(aString)
        }
        
//        let obable = MyObservable { (objectInitWithClosure)  in
//            objectInitWithClosure.on(event: "1")
//            objectInitWithClosure.on(event: "2")
//            objectInitWithClosure.on(event: "3")
//            objectInitWithClosure.on(event: "4")
//            objectInitWithClosure.on(event: "5")
//            objectInitWithClosure.on(event: "6")
//        }
//        
//        obable.map {return $0 + "test"}
        
        
//        let f = MyObserver<String> { (aString) in
//            print(aString + "hi")
//        }
//
//        f.on(event: "fs")
//        f.on(event: "2")
//        f.on(event: "3")
//        f.on(event: "4")
//        f.on(event: "5")
//        f.on(event: "6")
        

        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.isActive {
            return self.filteredTableData.count
        }else{
            return self.allCities.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"addCategoryCell")
        cell.selectionStyle =  UITableViewCellSelectionStyle.none
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = .black
        
        if self.resultSearchController.isActive {
            cell.textLabel?.text = filteredTableData[indexPath.row]
        } else {
            cell.textLabel?.text = allCities[indexPath.row] as? String
        }
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        print("query %@",searchPredicate.predicateFormat)
        getDataAsynchronous(searchPredicate) { (resultArray) in
            self.filteredTableData = resultArray
            self.tblView.reloadData()
        }
    }
    
    func getDataAsynchronous(_ searchPredicate:NSPredicate, completion:@escaping ([String])->()) {
        let timeRequest = Int(arc4random_uniform(5) + 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeRequest), execute: {
            [weak self] in
            let resultArray = (self?.allCities as! NSArray).filtered(using: searchPredicate)
            print("result %@",searchPredicate.predicateFormat)
            completion(resultArray as! [String])
        })
    }
    
    func getDataSynchronous(_ searchPredicate:NSPredicate, completion:@escaping ([String])->()) {
        let resultArray = self.allCities.filtered(using: searchPredicate)
        print("result %@",searchPredicate.predicateFormat)
        completion(resultArray as! [String])
    }
    
}


