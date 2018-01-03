//
//  ViewController.swift
//  Todoey
//
//  Created by Nils Nöhren on 03.01.18.
//  Copyright © 2018 Nils Nöhren. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demorgorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK - Tablevie Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
        cell.textLabel?.text = itemArray[indexPath.row]
    
        return cell
    }

    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        // print(itemArray[indexPath.row])
        
        
        // Checkmark select and deselect 
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
      
        
        
        // angewählte Reihe wird nur kurz erleucht
        tableView.deselectRow(at: indexPath, animated: true)
    
        
    }
    
    
}

