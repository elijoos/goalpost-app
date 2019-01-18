//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Eli Joos on 1/3/19.
//  Copyright © 2019 Eli Joos. All rights reserved.
//

import UIKit
import CoreData

//Public Vars
let appDelegate = UIApplication.shared.delegate as? AppDelegate
class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
  
    //Array of Goal
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //we are putting the fetch request in here because viewDidLoad will not be called if we go back to it from another view because it has already loaded it's just being presented
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        fetch { (complete) in
            //check to see if we should show or hide our tableview because if there's nothing in it we should hide it
            if goals.count >= 1 {
                tableView.isHidden = false
            } else {
                tableView.isHidden = true
            }
            
        }
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        presentDetail(createGoalVC)
        
        
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create the cell and pass in data, then return the cell so it can be used in tableView
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else {return UITableViewCell()}
        
        //PARSING THE DATA FROM GOALS
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
            return cell
            }
    
    //these funcs will allow us to delete rows by swiping
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    //the above function allows us to edit the cell. NOW we can call to editActionsForRowAt
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            
            // calling the function we created to delete a row and passing in the indexPath
            self.removeGoal(atIndexPath: indexPath)
            
            //Now we need to fetch all of the tableview data again! SO IN VIEWDIDAPPEAR we need to do that whole FETCH PROCCESS AGAIN! So let's put that in it's own funciton 'fetchCoreDataObjects'
            self.fetchCoreDataObjects()
           
            //deleting it
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //we still havn't yet RETURNED IT to our tableview we just created it. But before we do that let's set a background color
            
           
            
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        //RETURN OUR DELETE ACTION
        return [deleteAction]
        
    }
    
    
    
}



extension GoalsVC {
    //create functions that will fetch all of our data and save to an array
    func fetch(completion: (_ complete: Bool) -> ()) {
        //create a constant to hold managedContext
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        //fetch request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        
        do {
            //this returns the array of Goal, and we are appending them directly to our array 'goals'
            goals = try managedContext.fetch(fetchRequest) as! [Goal]
            print("successfully fetched data")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
        }
        
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        //pulling out the cell from the index path of the row
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed goal")
        } catch {
            print("Could not remove: \(error.localizedDescription)")
        }
    }
}
