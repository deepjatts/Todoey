//
//  ViewController.swift
//  Todoey
//
//  Created by Amandeep Singh on 16/02/18.
//  Copyright © 2018 Amandeep Singh. All rights reserved.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController {

    var tableArray = [Item]()
    
    var selectedCategory :Category?{
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = tableArray[indexPath.row].title
        
        
        cell.accessoryType = tableArray[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    
    //---------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(tableArray[indexPath.row])
        
        tableArray[indexPath.row].done = !tableArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW ITEM/s", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD", style: .default) { (alert) in
           
            let newitems = Item(context: self.context)
            
            newitems.title = textfield.text!
            newitems.done = false
            newitems.parentCategory = self.selectedCategory
            self.tableArray.append(newitems)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textfield = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func saveItems (){
        
        do{
           try context.save()
        }catch{
            print("Error saving \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    func loadItems(with request : NSFetchRequest<Item>  = Item.fetchRequest(), searchPredicate : NSPredicate? = nil){
      
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = searchPredicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        
        
        do{
        tableArray = try context.fetch(request)
        }catch{
            print("Error fetching \(error)")
        }
    }
}


//MARK: - Search bar methods

extension TodoTableViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with : request, searchPredicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

