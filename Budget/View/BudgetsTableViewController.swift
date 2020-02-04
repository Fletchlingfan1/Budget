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

    @IBOutlet var accountTotalTextField: UITextField!
    
    var budgets: [Budget] = []
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let fetchBudgets = NSFetchRequest<Budget>(entityName: "Budget")
        budgets = try! delegate.persistentContainer.viewContext.fetch(fetchBudgets)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return budgets.count
                }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetCell", for: indexPath) as! BudgetTableViewCell

        // Configure the cell...
        let budget = budgets[indexPath.row]
        cell.update(with: budget)
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
