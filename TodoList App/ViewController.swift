//
//  ViewController.swift
//  TodoList App
//
//  Created by Aamer Essa on 23/11/2022.
//

import UIKit
import CoreData
class ViewController: UIViewController,tasks  {
   
   
    
    
    @IBOutlet weak var tasksList: UITableView!
    var tasks = [Tasks]()
    var todayTasks = [Tasks]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // connect to DB
    
    
    let goToNewtViewBtn:UIButton = {
        let button = UIButton(frame:CGRect(x:0,y: 0,width: 60,height: 60))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor =  UIColor(red: 0.60, green: 0.71, blue: 1.00, alpha: 1.00)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksList.delegate = self
        tasksList.dataSource = self
        tasksList.backgroundColor = UIColor(red: 0.20, green: 0.31, blue: 0.63, alpha: 1.00)
        view.addSubview(goToNewtViewBtn)
        goToNewtViewBtn.addTarget(self, action: #selector(onClickOnAddTaksBtn), for: .touchUpInside)
        fetchAllTasks()
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        goToNewtViewBtn.frame = CGRect(x: view.frame.size.width - 70 , y: view.frame.size.height - 100, width: 60, height: 60 )
        tasksList.separatorStyle = .none
    }
    
    @objc func onClickOnAddTaksBtn(){
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let addNewTaskView = storyboard.instantiateViewController(withIdentifier: "AddNewTaskView") as! AddNewTaskView
        addNewTaskView.item = self
        addNewTaskView.modalPresentationStyle = .formSheet
        present(addNewTaskView, animated: true)

    }
    
    
 
    func addNewTask(taskName: String, taskDate: Date, note: String, taskChecked: Bool) {
        if taskName != ""{
            let newTask = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: managedObjectContext) as! Tasks
            newTask.task_name = taskName
            newTask.task_Date = taskDate
            newTask.note =  note
            tasks.append(newTask)
            
            do {
                try managedObjectContext.save()
            } catch {
                print("\(error)")
            }
            tasksList.reloadData()
            dismiss(animated: true)
        
        }
    }
    
    func editTask(taskName: String, taskDate: Date, note: String, destination:Int) {
        if taskName != "" {
          
            let editedTask = tasks[destination]
            editedTask.task_name = taskName
            editedTask.task_Date = taskDate
            editedTask.note = note
            
            do{
                try managedObjectContext.save()
                
            } catch {
                print("\(error)")
            } // end of catch
            
            tasksList.reloadData()
            dismiss(animated: true)
            }
           
        }
    
    func checkTask(check: Bool,destination:Int) {
        let cheked = tasks[destination]
        cheked.checked = check
        do{
            try managedObjectContext.save()
        } catch{
            print("\(error)")
        }
        tasksList.reloadData()
    }
    
    func fetchAllTasks (){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        do{
            let resualt = try managedObjectContext.fetch(request)
              tasks = resualt as! [Tasks]
        } catch {
            print("\(error)")
        }
        
        
      
    } // end of fetchAllTasks
     
    
   
    
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tasksList.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TasksTableViewCell
        cell.taskTitle.text = tasks[indexPath.section].task_name
        cell.taskNote.text = tasks[indexPath.section].note
        cell.checkBoxBtn.setImage(UIImage(named: tasks[indexPath.section].checked ? "chebboxCH" :"checkboxEmpty"), for: .normal)
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "YYYY/MM/dd"
        cell.taskDate.text = dateFormate.string(from:tasks[indexPath.section].task_Date!)
        cell.tasks = self
        cell.check = tasks[indexPath.section].checked
        cell.destination = indexPath.section 
        cell.accessoryType = .none
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            self.managedObjectContext.delete(self.tasks[indexPath.section])
            self.tasks.remove(at: indexPath.section)
            self.tasksList.reloadData()
            completionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .destructive, title: "Edit") { action, view, completionHandler in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let editView = storyBoard.instantiateViewController(withIdentifier: "EditTaskView") as! EditTask
            editView.task_date = self.tasks[indexPath.section].task_Date!
            editView.taskTitel = self.tasks[indexPath.section].task_name!
            editView.taskNote = self.tasks[indexPath.section].note!
            editView.destination = indexPath.section
            editView.modalPresentationStyle = .formSheet
            editView.item = self
            self.present(editView, animated: true)

            completionHandler(true)
        }
        
    
        editAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    
    
    
}
