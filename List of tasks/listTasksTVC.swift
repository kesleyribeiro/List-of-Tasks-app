//
//  listTasksTVC.swift
//  List of tasks
//
//  Created by Kesley Ribeiro on 30/Mar/17.
//  Copyright © 2017 App ao Cubo. All rights reserved.
//

import UIKit

var listTasks = [String]()

class listTasksTVC: UITableViewController {
    
    @IBOutlet weak var noTaskLbl: UILabel!
    
    var updateList: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show label
        noTaskLbl.isHidden = false
        
        if UserDefaults.standard.object(forKey: "listTasks") != nil {
            
            listTasks = UserDefaults.standard.object(forKey: "listTasks") as! [String]
        }
        
        // To pull the table for low to update the Tasks
        updateList = UIRefreshControl()
        updateList.attributedTitle = NSAttributedString(string: "To pull to bring up to date…")
        updateList.tintColor = blueColor
        updateList.addTarget(self, action: #selector(listTasksTVC.updateListTasks), for: .valueChanged)
        
        // Add updateList item in tableView
        self.tableView.addSubview(updateList)
    }
    
    // Update tableView always that view is presented
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // Function to update tasks in list of tasks
    func updateListTasks() {
        
        if !listTasks.isEmpty {
            // Hide label with message
            noTaskLbl.isHidden = true
        } else {
            // Show label
            noTaskLbl.isHidden = false
        }
        
        // Finish the animation of the update
        self.updateList.endRefreshing()
    }
    
    // Numbers of rows is equal listTasks count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTasks.count
    }
    
    // Configure the cell in tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Set the identifier of Cell to var cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")

        // If exist datas
        if !listTasks.isEmpty {

            // Set text label in cell
            cell.textLabel?.text = listTasks[indexPath.row]
            
            // Hide label with message
            noTaskLbl.isHidden = true
            
        // If no exist datas
        } else {
            // Show label
            noTaskLbl.isHidden = false
        }

        // Return the cell
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // If user seletec delete button
        if editingStyle == .delete {
            
            // Delete the row from the data source
            listTasks.remove(at: indexPath.row)
            
            // Delete data row of UserDefaults
            UserDefaults.standard.set(listTasks, forKey: "listTasks")
            
            // Update tableView
            tableView.reloadData()
        }
        // Call funtion to update list of tasks
        updateListTasks()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Define var editTaskVC to save view identifier from main.storyboard
        let editTaskVC = self.storyboard!.instantiateViewController(withIdentifier: "editTaskVC") as! editTaskVC
        self.navigationController?.present(editTaskVC, animated: true, completion: nil)
        
        // Set to var "editTask" the task information
        editTaskVC.editTask = listTasks[indexPath.row]
        
        // Set to var "indexList" the index of the task
        editTaskVC.indexList = indexPath.row
    }
    
}
