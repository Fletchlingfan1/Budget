//
//  TransactionsViewController.swift
//  Budget
//
//  Created by Jacob Mower on 1/24/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    

    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetTotalLabel: UILabel!
    
    var budgetName: String?
    var budgetTotal: Double?
    var currencyFormater = NumberFormatter()
    var selectedBudget: Budget?
    var sortedTransactions: [Transactions] {
        guard let transactions = selectedBudget?.transactions as? Set<Transactions> else { return [] }
        return transactions.sorted(by: { $0.transactionDate ?? Date() > $1.transactionDate ?? Date() })

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyFormater.numberStyle = .currency
        
        if let budgetNamePassed = budgetName {
            budgetNameLabel.text = budgetNamePassed
        }
        
        if let budgetTotalPassed = budgetTotal {
            budgetTotalLabel.text = currencyFormater.string(for: budgetTotalPassed)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentTransactions = selectedBudget?.transactions else { return 0 }
        return currentTransactions.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let selectedTransaction = sortedTransactions[indexPath.row]
                BudgetController.sharedController.deleteTransaction(transaction: selectedTransaction)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionTableViewCell
        
        //Configure the cell...
        let transactions = self.sortedTransactions[indexPath.row]
        cell.update(with: transactions)
        return cell
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTransaction" {
            guard let addTransactionsVC = segue.destination as? AddTransactionTableViewController else {return}
            addTransactionsVC.currentBudget = selectedBudget
            
        }
    }
    

}
