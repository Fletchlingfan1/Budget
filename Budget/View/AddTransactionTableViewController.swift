//
//  AddTransactionTableViewController.swift
//  Budget
//
//  Created by Jacob Mower on 1/24/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit

class AddTransactionTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var transactionDatePicker: UIDatePicker!
    @IBOutlet var datePickerLabel: UILabel!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var transactionName: UITextField!
    @IBOutlet var transactionAmount: UITextField!
//    @IBOutlet var transactionNotes: UITextView!
    
    var dateEditing = false {
        didSet {
        tableView.beginUpdates()
        tableView.endUpdates()
        }
    }
    
    var datePickerHeight = 0
    var editingDatePicker = false
    var transaction: Transactions?
    var currentBudget: Budget?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transactionName.delegate = self
        self.notesTextView.delegate = self
        self.transactionAmount.delegate = self
        //formatting for date label box
        datePickerLabel!.layer.borderWidth = 1
        datePickerLabel!.layer.cornerRadius = 5.0
        if traitCollection.userInterfaceStyle == .dark {
            datePickerLabel!.layer.borderColor = #colorLiteral(red: 0.199973762, green: 0.2000150383, blue: 0.1999711692, alpha: 1)
        } else if traitCollection.userInterfaceStyle == .light {
            datePickerLabel!.layer.borderColor = #colorLiteral(red: 0.8029057384, green: 0.8030220866, blue: 0.8028803468, alpha: 1)
        }
        //formatting for notes box
        if traitCollection.userInterfaceStyle == .dark {
            notesTextView!.layer.borderColor = #colorLiteral(red: 0.199973762, green: 0.2000150383, blue: 0.1999711692, alpha: 1)
        } else if traitCollection.userInterfaceStyle == .light {
            notesTextView!.layer.borderColor = #colorLiteral(red: 0.8029057384, green: 0.8030220866, blue: 0.8028803468, alpha: 1)
        }
        notesTextView!.layer.borderWidth = 1
        notesTextView!.layer.cornerRadius = 5.0
        
        guard let selectedTransaction = transaction else {return}
        transactionAmount.text = "\(selectedTransaction.transactionAmount)"
        transactionName.text = selectedTransaction.transactionName
        notesTextView.text = selectedTransaction.transactionNotes
        
        guard let setTransactionDate = selectedTransaction.transactionDate else {return}
        
        datePickerLabel.text = BudgetController.sharedController.stringForDate(date: setTransactionDate)
        
        transactionDatePicker.date = setTransactionDate

    }

    // MARK: - Table view data source

    @IBAction func transactionSaveButton(_ sender: Any) {
        guard let name = transactionName.text,
            let amount = transactionAmount.text,
            let date: Date = transactionDatePicker.date,
            let notes = notesTextView.text,
            let amountDouble = Double(amount),
            let currentBudget = currentBudget else {
            return
            
        }
        
        if let transaction = transaction {
            //edit transaction
            transaction.transactionName = name
            transaction.transactionAmount = amountDouble
            transaction.transactionDate = date
            transaction.transactionNotes = notes
            BudgetController.sharedController.saveBudget()
        } else {
            //new transaction
            BudgetController.sharedController.addTransaction(transactionAmount: amountDouble, transactionDate: date, transactionName: name, transactionNotes: notes, budget: currentBudget)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    //MARK: Date picker stuff
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 4, section: 0){
            if dateEditing == true {
                return transactionDatePicker.frame.height
            } else {
                return 0
            }
        } else if indexPath == IndexPath(row: 0, section: 0){
            return CGFloat(141.0)
        } else if indexPath == IndexPath(row: 5, section: 0){
            return CGFloat(174)
        } else {
            return UITableView.automaticDimension
        }
    }


     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath(row: 3, section: 0) {
            dateEditing = !dateEditing
            datePickerLabel.text = BudgetController.sharedController.stringForDate(date: transactionDatePicker.date)
            transactionAmount.resignFirstResponder()
            transactionName.resignFirstResponder()
            notesTextView.resignFirstResponder()
        } else {
            dateEditing = !dateEditing
            datePickerLabel.text = BudgetController.sharedController.stringForDate(date: transactionDatePicker.date)
        }

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dateEditing = false
        if datePickerLabel.text != "" {
        datePickerLabel.text = BudgetController.sharedController.stringForDate(date: transactionDatePicker.date)
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        dateEditing = false
        if datePickerLabel.text != "" {
        datePickerLabel.text = BudgetController.sharedController.stringForDate(date: transactionDatePicker.date)
        }
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
