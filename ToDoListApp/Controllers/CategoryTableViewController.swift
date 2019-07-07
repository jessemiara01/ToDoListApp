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
        loadDataIntoList()
        }
    // MARK: - Data handling methods
    
    func saveToList(category : Categories){
        do{
            try realm.write {
                realm.add(category)
            }
        } catch{
            print("Could not write to database \(error)")
        }
    }
    

    func loadDataIntoList(){
        categoryList = realm.objects(Categories.self)
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryList?[indexPath.row].categoryName ?? "No data entered"
        
        return cell
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
            let category = Categories()
            
            category.categoryName = textField.text!
            
            self.saveToList(category: category)
            self.tableView.reloadData()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Category"
            textField = alertTextField
        }
        
        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
        
    }
    

    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemsTableViewController

        if let newIndexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategories = categoryList?[newIndexPath.row]
        }
        
        
        
    }


}
