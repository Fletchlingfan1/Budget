//
//  BudgetController.swift
//  Budget
//
//  Created by Jordy Vazquez on 1/23/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import Foundation
import CoreData

class BudgetController {
    
    static let sharedController = BudgetController()
    
    var budget: [Budget] {
        let request: NSFetchRequest<Budget> = Budget.fetchRequest()
        
        do {
            return try Stack.context.fetch(request).sorted(by: { $0.budgetName ?? "" < $1.budgetName ?? "" })        } catch {
            return []
        }
    }
    
    func saveBudget()  {
        Stack.saveContext()
    }
    
    func addBudget(budgetName: String, budgetAmount: Double) {
        let _ = Budget(budgetName: budgetName, budgetAmount: budgetAmount)
        saveBudget()
    }
    
    func addTransaction(transactionAmount: Double, transactionDate: Date, transactionName: String, transactionNotes: String) {
        let _ = Transactions(transactionAmount: transactionAmount, transactionName: transactionName, transactionNotes: transactionNotes, transactionDate: transactionDate)
        saveBudget()
    }
    
    func addAccount(accountName: String, accountAmount: Double) {
        let _ = Account(accountAmount: accountAmount, accountName: accountName)
        saveBudget()
    }
    
    func deleteBudget(budget:Budget) {
        Stack.context.delete(budget)
        saveBudget()
    }
    
    func deleteAccount(account: Account) {
        Stack.context.delete(account)
        saveBudget()
    }
    
    func deleteTransaction(transaction: Transactions) {
        Stack.context.delete(transaction)
        saveBudget()
    }
}
