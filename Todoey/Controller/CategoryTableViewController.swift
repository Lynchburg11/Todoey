//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Nils Nöhren on 06.01.18.
//  Copyright © 2018 Nils Nöhren. All rights reserved.
//

import UIKit
import CoreData


class CategoryTableViewController: UITableViewController {

    var CategoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
        
    }

    
    
//MARK:                         --------  Add New Items  --------
   
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
    var textField = UITextField()

    let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)

    let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
        let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
        self.CategoryArray.append(newCategory)
        
        self.saveCategory()

        }
    
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create a new Category"
            textField = alertTextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }

    
    
    
//MARK: ---- TableView Datasource Methods ---
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryArray.count
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = CategoryArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
        
        
    }
    
    
    
    
// MARK: --- Data Manipulation Methods (Save / Load Data) ---
    
    
                    // -------  Save Items --------
    func saveCategory() {
        
        do {
            try context.save()
            print("Items successfully saved in Container")
        } catch {
            print("Error saving Items in Container, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
                // ------- Load Items --------
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do{
            CategoryArray = try context.fetch(request)
        }catch{
            print("Error fetching Data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    
    
    
    
    
//MARK: ---- TableView Delegate Methods ---
    
    
    
    
   
    
    
}
