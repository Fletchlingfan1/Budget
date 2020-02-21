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

    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add new budget", message: nil, preferredStyle: .alert)
        
        add = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let budgetName = alert.textFields! [0] as UITextField
            let budgetAmount = alert.textFields! [1] as UITextField
            
            if budgetName.text == "" {
                let alertController = UIAlertController(title: "You need a Name and Total", message: nil, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
                
            } else if budgetAmount.text == "" {
                                let alertController = UIAlertController(title: "You need a Name and Total", message: nil, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
                
            } else {
                guard let name = budgetName.text,
                    let amount = budgetAmount.text,
                    let amountDouble = Double(amount) else {return}
                
                BudgetController.sharedController.addBudget(budgetName: name, budgetAmount: amountDouble)
                self.tableView.reloadData()
                self.calculateSum()
            }
        }
        
        self.validation()
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.autocapitalizationType = .sentences
            self.nameTextField = textField
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using:
                {_ in
                    self.validation()
            })
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Total"
            textField.keyboardType = .decimalPad
            self.totalTextField = textField
            // Observe the UITextFieldTextDidChange notification to be notified in the below block when text is changed
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using:
                {_ in
                    self.validation()
                
            })
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        
        alert.addAction(add!)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    var nameTextField: UITextField?
    var totalTextField: UITextField?
    var add: UIAlertAction?
    
    func validation() {
        //look at what is in name textfield
        //look at what is in total textfield
        
        let textCountName = nameTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        let textIsNotEmptyName = textCountName > 0
        
        let textCountTotal = totalTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
        let textIsNotEmptyTotal = textCountTotal > 0
        
        // If the text contains non whitespace characters, enable the OK Button
        if textIsNotEmptyName == true && textIsNotEmptyTotal == true {
            add?.isEnabled = true
        } else {
            add?.isEnabled = false
        }
    }
    
    func newBudget(_ answer: String) {
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let budget = BudgetController.sharedController.budget[indexPath.row]
            BudgetController.sharedController.deleteBudget(budget: budget)
            tableView.deleteRows(at: [indexPath], with: .fade)
            calculateSum()
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
        if segue.identifier == "toTransactions" {
            guard let transactionsVC = segue.destination as? TransactionsViewController, let selectedRow = tableView.indexPathForSelectedRow?.row else {return}
            let budget = BudgetController.sharedController.budget[selectedRow]
            transactionsVC.selectedBudget = budget
            
        }
        
        /* if the segue is "toTransactions", then:
         * a) get the new view Controller
         * b) get the values of the row that was tapped
         * c) pass the budget name of the row that was tapped to the new view controller
         */
        if segue.identifier == "toTransactions" {
            guard let addBudgetVC = segue.destination as? TransactionsViewController, let selectedRow = tableView.indexPathForSelectedRow?.row else {return}
            let budget = self.budgets[selectedRow]
            addBudgetVC.budgetName = budget.budgetName
            addBudgetVC.budgetTotal = budget.budgetAmount
        }
    }
    
}
