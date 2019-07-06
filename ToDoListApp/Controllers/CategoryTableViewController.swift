//
//  CategoryTableViewController.swift
//  ToDoListApp
//
//  Created by Jesse Miara on 7/6/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryList : Results<Categories>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(realm.configuration.fileURL)

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryList?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = categoryList?[indexPath.row].categoryName ?? "No data entered"
        
        

        return cell
    }




    // MARK: - Navigation


}
