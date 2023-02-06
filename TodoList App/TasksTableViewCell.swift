//
//  TasksTableViewCell.swift
//  TodoList App
//
//  Created by Aamer Essa on 23/11/2022.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskNote: UILabel!
    var check = Bool()
    var destination = Int()
    var tasks:tasks?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    
    @IBAction func onClickCheckedBtn(_ sender: UIButton) {
        tasks?.checkTask(check: !check, destination: destination)

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
