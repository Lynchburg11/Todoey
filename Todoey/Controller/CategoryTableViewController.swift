//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Nils Nöhren on 06.01.18.
//  Copyright © 2018 Nils Nöhren. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    
    var categories: Results<Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
        
    }

    
//MARK:                      ---- TableView Datasource Methods ---
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "** No Categories added yet! **"
        
        return cell
        
        
    }
    
    
    
//MARK:                         --------  Add New Items  --------
   
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
    var textField = UITextField()

    let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)

    let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
        let newCategory = Category()
        newCategory.name = textField.text!
        
        
        self.save(category: newCategory)

        }
    
        alert.addTextField { (alertTextfield) in
            textField = alertTextfield
            alertTextfield.placeholder = "Create a new Category"
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }

    
    
//MARK:             ---- TableView Delegate Methods ---
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        // flashes row
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    
    
// MARK: --- Data Manipulation Methods (Save / Load Data) ---
    
    
                    // -------  Save Items --------
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
            print("Items successfully saved in Realm")
        } catch {
            print("Error saving Category in Realm, \(error)")
        }
        
        tableView.reloadData()
    }
    

    
    
                // ------- Load Items --------
    func loadCategory() {
        
        categories = realm.objects(Category.self)
        
        
        
        tableView.reloadData()

    }



    

    
    
}
