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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = tableArray[indexPath.row].itemName
        
        
        cell.accessoryType = tableArray[indexPath.row].checked ? .checkmark : .none
        
        return cell
    }
    
    
    //---------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(tableArray[indexPath.row])
        
        tableArray[indexPath.row].checked = !tableArray[indexPath.row].checked
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newItem = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW ITEM/s", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD", style: .default) { (alert) in
            let items = Items()
            items.itemName = newItem.text!
            self.tableArray.append(items)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newItem = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func saveItems (){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.tableArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("Error encoding table array: \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            tableArray = try decoder.decode([Items].self, from: data)
            } catch{
                print("Error decoding table array: \(error)")
            }
        }
    }
}

