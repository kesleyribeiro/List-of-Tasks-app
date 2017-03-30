//
//  addTaskVC.swift
//  List of tasks
//
//  Created by Kesley Ribeiro on 30/Mar/17.
//  Copyright © 2017 App ao Cubo. All rights reserved.
//

import UIKit

class addTaskVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addTaskBtn: UIButton!
    @IBOutlet weak var newTask: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Round edge of Save button
        addTaskBtn.layer.cornerRadius = addTaskBtn.bounds.width / 9
        
        // Delegate the textField
        newTask.delegate = self
        
        // Add target to execute function in textfield
        newTask.addTarget(self, action: #selector(addTaskVC.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // Begin the button inactive
        addTaskBtn.isEnabled = false
        addTaskBtn.alpha = 0.3
    }
    
    // If some information in textfiel was modified
    func textFieldDidChange(_ textField : UITextView) {
        
        // If textfield is empty - inactivate Save button
        if newTask.text!.isEmpty {
            
            addTaskBtn.isEnabled = false
            addTaskBtn.alpha = 0.3
            
        } // If textfield was modified - activate Save button
        else {
            addTaskBtn.isEnabled = true
            addTaskBtn.alpha = 1            
        }
    }
    
    // Add task button
    @IBAction func addTask(_ sender: Any) {
        
        // Remove the keyboard
        self.view.endEditing(false)
        
        // Add in array an new task
        listTasks.append(newTask.text!)
        
        // Delete text
        newTask.text = ""
        
        // Save the data in user defaults
        UserDefaults.standard.set(listTasks, forKey: "listTasks")
        
        // Switch to other view with index 1
        self.tabBarController?.selectedIndex = 1
    }
    
    // Hide keyboard when user touch in view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newTask.resignFirstResponder()
        return true
    }

}
