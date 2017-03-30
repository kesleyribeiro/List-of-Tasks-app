//
//  editTaskVC.swift
//  List of tasks
//
//  Created by Kesley Ribeiro on 30/Mar/17.
//  Copyright © 2017 App ao Cubo. All rights reserved.
//

import UIKit

class editTaskVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet var task: UITextField!
    
    // Save the information received from listTasksTVC
    var editTask = String()
    
    // Save the index of the task actual
    var indexList = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        // Round edge of Save button
        saveBtn.layer.cornerRadius = saveBtn.bounds.width / 9
        
        // Delegate the textField
        task.delegate = self
        
        // Add target to execute function in textfield
        task.addTarget(self, action: #selector(editTaskVC.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Set text to textfield
        task.text = "\(editTask)"

        // Begin the button inactive
        saveBtn.isEnabled = false
        saveBtn.alpha = 0.3
    }
    
    // If some information in textfiel was modified
    func textFieldDidChange(_ textField : UITextView) {
        
        // If textfield is empty - inactivate Save button
        if task.text!.isEmpty {
            
            saveBtn.isEnabled = false
            saveBtn.alpha = 0.3
            
        } // If textfield was modified - activate Save button
        else {
            saveBtn.isEnabled = true
            saveBtn.alpha = 1
        }
    }
    
    @IBAction func saveModifications(_ sender: Any) {

        // Remove the keyboard
        self.view.endEditing(false)
        
        // Remove task modified in list tasks
        listTasks.remove(at: indexList)

        // Add in listTasks an new task
        listTasks.append(task.text!)
        
        // Save the new data in user defaults
        UserDefaults.standard.set(listTasks, forKey: "listTasks")

        // To back listTasksTVC and show list of tasks
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toBackListTasks(_ sender: Any) {
        
        // To back listTasksTVC and show list of tasks
        dismiss(animated: true, completion: nil)
    }
    
    // Hide keyboard when user touch in view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        task.resignFirstResponder()
        return true
    }

    // Status white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}
