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

    
//MARK:                      ---- TableView Datasource Methods ---
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryArray.count
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = CategoryArray[indexPath.row].name
        
        return cell
        
        
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
            destinationVC.selectedCategory = CategoryArray[indexPath.row]
        }
    }
    
    
    
    
    
// MARK: --- Data Manipulation Methods (Save / Load Data) ---
    
    
                    // -------  Save Items --------
    func saveCategory() {
        
        do {
            try context.save()
            print("Items successfully saved in Container")
        } catch {
            print("Error saving Category in Container, \(error)")
        }
        
        tableView.reloadData()
    }
    

    
    
                // ------- Load Items --------
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        
        do{
            CategoryArray = try context.fetch(request)
        }catch{
            print("Error fetching Category from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    

    

    
    
}
