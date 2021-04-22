//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Jantsen Tanner on 4/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    //Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    @IBOutlet weak var taskNotesTextView: UITextView!
    
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    @IBOutlet weak var isCompleteSwitch: UISwitch!
    
    //landing pad
    var task: Task?
    var date: Date?
    
    
    //Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwrappedTask = task else { return }
        taskNameTextField.text = unwrappedTask.name
        taskNotesTextView.text = unwrappedTask.notes
        if let unwrappedDueDate = unwrappedTask.dueDate {
            taskDueDatePicker.date = unwrappedDueDate
        }
        isCompleteSwitch.isOn = unwrappedTask.isComplete
        
        
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else { return }
        let taskNotes = taskNotesTextView.text
        let taskDate = taskDueDatePicker.date
        if let unwrappedTask = task {
            TaskController.sharedInstance.update(task: unwrappedTask, newName: taskName, newNotes: taskNotes, newDueDate: taskDate, isComplete: isCompleteSwitch.isOn)
            
        } else {
            TaskController.sharedInstance.createTaskWith(name: taskName, notes: taskNotes, dueDate: taskDate, isComplete: isCompleteSwitch.isOn)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
