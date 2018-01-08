//
//  ViewController.swift
//  Todoey
//
//  Created by Nils Nöhren on 03.01.18.
//  Copyright © 2018 Nils Nöhren. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
//
    var todoItems: Results<item>?
    
    let realm = try! Realm()
    
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    
            // ---------------   VIEW DID LOAD --------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))


    }

//MARK          ----------  Tableview Datasource Methods  -----------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            // Ternary operator ==>
            // value = condition ? valueIfTrue : valueIfFalse (same as if / else)
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "** No items added! ** "
        }

        return cell
    
    }


    
//MARK          ------------ TableView Delegate Methods  ----------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if let item = todoItems?[indexPath.row]{
            do {
                try realm.write {
                item.done = !item.done
            }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        

        
        // flashes selected row
        tableView.deselectRow(at: indexPath, animated: true)
 
    }
    
    
    
//MARK  ---------------   Add New Items   ----------------------------

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item Button on UIAlert
            
            if let currentCategory = self.selectedCategory{
                do {
                    try self.realm.write {
                        let newItem = item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }
                    catch {
                        print("Error saving new Items, \(error)")
                    }
                
            
          
            }
            
            self.tableView.reloadData()

            
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create a new Item"
            textField = alertTextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
  
    }
    
//MARK ---------------- Model Manupulation Methods -----------------------
//
//    func saveItems() {
//
//        do {
////          try context.save()
////        print("Items successfully saved in Container")
//        } catch {
//            print("Error saving Items in Container, \(error)")
//        }
//
//        tableView.reloadData()
//    }
//
//
//
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)


        tableView.reloadData()

    }

}

//MARK:  Search Bar methods

extension TodoListViewController: UISearchBarDelegate{


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

          todoItems = todoItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)

        tableView.reloadData()
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}


