//
//  TransactionsViewController.swift
//  Budget
//
//  Created by Jacob Mower on 1/24/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    @IBOutlet var transactionTableView: UITableView!
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetTotalLabel: UILabel!
    
    var budgetName: String?
    var budgetTotal: Double?
    var currencyFormater = NumberFormatter()
    var selectedBudget: Budget?
    
    
    var sortedTransactions: [Transactions] {
        guard let transactions = selectedBudget?.transactions as? Set<Transactions> else { return [] }
        return transactions.sorted(by: { $0.transactionDate ?? Date() > $1.transactionDate ?? Date() })
        
    }
    
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
        transactionTableView.reloadData()
        negativeTransactionSum()
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
            negativeTransactionSum()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionTableViewCell
        
        //Configure the cell...
        let transactions = self.sortedTransactions[indexPath.row]
        cell.transactionAmountTextField.text = currencyFormater.string(for: transactions.transactionAmount)
        cell.transactionDateTextField.text = transactions.transactionDate?.toString(style: .short)
        cell.transactionNameTextField.text = transactions.transactionName
        return cell
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTransaction" {
            guard let addTransactionsVC = segue.destination as? AddTransactionTableViewController else {return}
            addTransactionsVC.currentBudget = selectedBudget
        } else if segue.identifier == "editTransaction" {
            guard let editTransactionVC = segue.destination as? AddTransactionTableViewController, let selectedRow = transactionTableView.indexPathForSelectedRow?.row else {return}
            let transaction = self.sortedTransactions[selectedRow]
            editTransactionVC.currentBudget = selectedBudget
            editTransactionVC.transaction = transaction
//            editTransactionVC.transactionAmount.text = "\(transaction.transactionAmount)"
//            editTransactionVC.datePickerLabel.text = BudgetController.sharedController.stringForDate(date: transaction.transactionDate)
            

        }
    }
    
    func negativeTransactionSum(){
        guard var sum = selectedBudget?.budgetAmount else {return}
        for transaction in sortedTransactions {
            sum -= transaction.transactionAmount
        }
        budgetTotalLabel.text = currencyFormater.string(for: sum)
    }
}

extension Date{
    func toString(style:DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}



