//
//  EditTask.swift
//  TodoList App
//
//  Created by Aamer Essa on 27/11/2022.
//

import UIKit

class EditTask: UIViewController {

    @IBOutlet weak var taskDate: UIDatePicker!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var titleTask: UITextField!
    var taskTitel = String()
    var task_date = Date()
    var taskNote = String()
     var item:tasks?
    var destination = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        note.autocapitalizationType = .words
        note.isScrollEnabled = false
        note.layer.cornerRadius = 10
        titleTask.text = taskTitel
        note.text = taskNote 
        taskDate.date = task_date 
        
    }
    
    @IBAction func onClickEditBtn(_ sender: Any) {
        item?.editTask(taskName: titleTask.text!, taskDate: taskDate.date, note: note.text!, destination: destination)
    }
    

}
