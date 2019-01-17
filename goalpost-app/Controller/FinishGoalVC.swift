//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Eli Joos on 1/14/19.
//  Copyright © 2019 Eli Joos. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    var goalDescription: String!
    var goalType: GoalType!
    
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
        //pointsTextField.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createGoalBtn.bindToKeyboard()
    }
    

    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        //Pass data into Core Data Goal Model
        //Save our data
        
        if pointsTextField.text != nil {
            
            self.save { (complete) in
                //code
                
            }
            dismissDetail()
        }
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
    
        //this is how we get our managed context
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        //create instance of goal, and given it a managed context that it needs to have so it KNOWS where it's SAVING THE DATA
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        //we need to pull the rawValue out!!! core data won't except an enum type
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        //as of now we haven't told it to save.
       
        do {
            try managedContext.save()
            
            print("successfully saved data")
            
        } catch {
            debugPrint("Could not save \(error.localizedDescription)")
            
        }
        
    }
    
    
}
