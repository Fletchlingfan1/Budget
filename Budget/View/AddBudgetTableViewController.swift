//
//  AddBudgetTableViewController.swift
//  Budget
//
//  Created by Jacob Mower on 1/24/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit

class AddBudgetTableViewController: UITableViewController {
    
    @IBOutlet var budgetTitleTextField: UITextView!
    @IBOutlet var budgetName: UITextField!
    @IBOutlet var budgetAmount: UITextField!
    
    var budget: Budget?
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
    @IBAction func saveBudget(_ sender: Any){
        guard let name = budgetName.text,
            let amount = budgetAmount.text,
            let amountDouble = Double(amount) else {return}
        
        if let budget = budget {
            //edit budget
            budget.budgetName = name
            budget.budgetAmount = amountDouble
            BudgetController.sharedController.saveBudget()
        } else {
            //new budget
            BudgetController.sharedController.addBudget(budgetName: name, budgetAmount: amountDouble)
        }
        self.navigationController?.popViewController(animated: true)
    }
    



}
