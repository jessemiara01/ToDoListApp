//
//  ItemsTableViewController.swift
//  ToDoListApp
//
//  Created by Jesse Miara on 7/6/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import RealmSwift

class ItemsTableViewController: UITableViewController {
    let realm = try! Realm()
    
    var itemList : Results<ToDoItems>?
    
    var selectedCategories : Categories? {
        didSet{
            loadItemsIntoList()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Data handling methods
    
    func loadItemsIntoList(){
        itemList = selectedCategories?.itemsForCategory.sorted(byKeyPath: "itemsToDo")
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategories{
                do{
                    try self.realm.write {
                        let item = ToDoItems()
                        item.itemsToDo = textField.text!
                        currentCategory.itemsForCategory.append(item)
                    }
                } catch{
                    print("Couldn't write data: \(error)")
                }
            }
            self.tableView.reloadData()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemList?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)

        cell.textLabel?.text = itemList?[indexPath.row].itemsToDo ?? "No Data Added"

        return cell
    }
    
    
    

}
