//
//  Tasks.swift
//  TodoList App
//
//  Created by Aamer Essa on 25/11/2022.
//

import UIKit

protocol tasks {
    
    func addNewTask(taskName:String , taskDate:Date ,note:String, taskChecked:Bool)
    func checkTask(check:Bool,destination:Int)
    func editTask(taskName:String , taskDate:Date ,note:String,destination:Int)
   
}

