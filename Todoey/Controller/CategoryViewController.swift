//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Amandeep Singh on 25/02/18.
//  Copyright © 2018 Amandeep Singh. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var tableArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    // MARK: - ADD BUTTON
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW CATEGORY/s", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD", style: .default) { (alert) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textfield.text!
           
            
            self.tableArray.append(newCategory)
            self.saveItems()
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
        return tableArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = tableArray[indexPath.row].name
        
        return cell
    }
    
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = tableArray[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manupulation methods
    
    
    func saveItems (){
        
        do{
            try context.save()
        }catch{
            print("Error saving \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    func loadItems(with request : NSFetchRequest<Category>  = Category.fetchRequest() ){
        
        do{
            tableArray = try context.fetch(request)
        }catch{
            print("Error fetching \(error)")
        }
    }
}

