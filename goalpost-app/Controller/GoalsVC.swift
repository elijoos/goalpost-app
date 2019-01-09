//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Eli Joos on 1/3/19.
//  Copyright © 2019 Eli Joos. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = false
    }


    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        print("button was pressed")
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create the cell and pass in data, then return the cell so it can be used in tableView
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else {return UITableViewCell()}
        cell.configureCell(description: "Eat salad twice a week.", type: .shortTerm, goalProgressAmount: 2)
            return cell
            }
        }


