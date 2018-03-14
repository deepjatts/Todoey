//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Amandeep Singh on 25/02/18.
//  Copyright © 2018 Amandeep Singh. All rights reserved.
//

import UIKit
import SwipeCellKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController{
    
    var realm = try! Realm()
    
    var tableArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        tableView.separatorStyle = .none
        tableView.rowHeight = 75.0
    }
    
    // MARK: - ADD BUTTON
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW CATEGORY/s", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD", style: .default) { (alert) in
            
            let newCategory = Category()
            
            newCategory.name = textfield.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            
            self.saveItems(category : newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = tableArray?[indexPath.row]{
            cell.textLabel?.text = category.name ?? "no categories added yet"
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        return cell
    }
    
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = tableArray?[indexPath.row] 
        }
    }
    
    
    //MARK: - Data Manupulation methods
    
    
    func saveItems (category : Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    func loadItems(){
        
        tableArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = tableArray?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }catch{
                print("Error deleting \(error)")
            }
        }
    }
}



