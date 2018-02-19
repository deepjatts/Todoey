//
//  ViewController.swift
//  Todoey
//
//  Created by Amandeep Singh on 16/02/18.
//  Copyright © 2018 Amandeep Singh. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {

    var tableArray = [Items]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Items()
        newItem.itemName = "Find Mike"
        
        if let item = defaults.array(forKey: "ToDoListArray") as? [Items] {
            tableArray = item
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = tableArray[indexPath.row].itemName
        
        
        cell.accessoryType = tableArray[indexPath.row] ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(tableArray[indexPath.row])
        
        tableArray[indexPath.row].checked = !tableArray[indexPath.row].checked
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newItem = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW ITEM/s", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD", style: .default) { (alert) in
            
            let items = Items()
            items.itemName = newItem.text!
           
            self.tableArray.append(items)
            
            self.defaults.set(self.tableArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newItem = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
}

