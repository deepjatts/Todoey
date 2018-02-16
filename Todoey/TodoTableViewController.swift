//
//  ViewController.swift
//  Todoey
//
//  Created by Amandeep Singh on 16/02/18.
//  Copyright © 2018 Amandeep Singh. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {

    let tableArray = ["1","2","3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = tableArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(tableArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
}

