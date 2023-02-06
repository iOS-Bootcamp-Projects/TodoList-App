//
//  AddNewTaskView.swift
//  TodoList App
//
//  Created by Aamer Essa on 23/11/2022.
//

import UIKit

class AddNewTaskView: UIViewController {

    @IBOutlet weak var taskDate: UIDatePicker!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var taskTitle: UITextField!
    
    
    var item:tasks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        note.autocapitalizationType = .words
        note.isScrollEnabled = false
        note.layer.cornerRadius = 10
        
      
        
    }

    @IBAction func onClickCreateBtn(_ sender: Any) {
        item?.addNewTask(taskName: taskTitle.text!, taskDate: taskDate.date, note: note.text!, taskChecked: false) 
        
    }
    

}
