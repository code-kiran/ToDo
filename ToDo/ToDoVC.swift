//
//  ViewController.swift
//  ToDo
//
//  Created by kiran on 9/20/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit

class ToDoVC: UITableViewController {
    let defaults = UserDefaults.standard
    var toDoLists = ["task1", "task2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoList") as? [String] {
            toDoLists = items
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoLists[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
       
    }
    
    @IBAction func addToDoItem(_ sender: UIBarButtonItem) {
       var textField = UITextField()
        let alert = UIAlertController(title: "Add Your To Do Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.toDoLists.append(textField.text!)
            self.defaults.set(self.toDoLists, forKey: "ToDoList")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    

}

