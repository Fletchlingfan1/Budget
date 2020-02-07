//
//  BudgetsTableViewController.swift
//  Budget
//
//  Created by Jacob Mower on 1/22/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit
import CoreData

class BudgetsTableViewController: UITableViewController {

    @IBOutlet var accountTotalLabel: UILabel!
    
    var budgets: [Budget] {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let fetchBudgets = NSFetchRequest<Budget>(entityName: "Budget")
        return try! delegate.persistentContainer.viewContext.fetch(fetchBudgets)
    }
    
    var currencyFormatter = NumberFormatter()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyFormatter.numberStyle = .currency
        
        // This makes the Edit button work.
        navigationItem.leftBarButtonItem = editButtonItem
        
        //        tableView.reloadData()
    }
    
    
    func calculateSum() {
        
        var sum = 0.0
        for budget in budgets {
            sum += budget.budgetAmount
        }
        accountTotalLabel.text = currencyFormatter.string(for: sum)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        calculateSum()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return budgets.count
                }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetCell", for: indexPath) as! BudgetTableViewCell

        // Configure the cell...
        let budget = self.budgets[indexPath.row]
        cell.budgetNameLabel.text = budget.budgetName
        cell.budgetAmountLabel.text = currencyFormatter.string(for: budget.budgetAmount)
        
        return cell
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let budget = BudgetController.sharedController.budget[indexPath.row]
            BudgetController.sharedController.deleteBudget(budget: budget)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //detect the correct segue, the edit segue
        if segue.identifier == "editBudget" {
            
            //if it's the edit budget segue then get the budget tapped and grab the view controller
            guard let addBudgetVC = segue.destination as? AddBudgetTableViewController, let selectedRow = tableView.indexPathForSelectedRow?.row else {return}
            let budget = BudgetController.sharedController.budget[selectedRow]
            
            //and give the destination view controller the budget you just tapped
            addBudgetVC.loadViewIfNeeded()
            addBudgetVC.budget = budget
        }
    }
    
}
