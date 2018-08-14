//
//  ViewController.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 7/31/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import UIKit


class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate,UISearchResultsUpdating {
    
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




