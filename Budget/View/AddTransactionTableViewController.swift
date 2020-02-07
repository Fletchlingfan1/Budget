//
//  AddTransactionTableViewController.swift
//  Budget
//
//  Created by Jacob Mower on 1/24/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit

class AddTransactionTableViewController: UITableViewController {
    
    @IBOutlet var transactionDatePicker: UIDatePicker!
    @IBOutlet var datePickerLabel: UILabel!
    @IBOutlet var notesTextView: UITextView!
    
    var dateEditing = false {
        didSet {
        tableView.beginUpdates()
        tableView.endUpdates()
        }
    }
    
    var datePickerHeight = 0
    var editingDatePicker = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //formatting for date label box
        datePickerLabel!.layer.borderWidth = 1
        datePickerLabel!.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        datePickerLabel!.layer.cornerRadius = 5.0
        //formatting for notes box
        notesTextView!.layer.borderWidth = 1
        notesTextView!.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        notesTextView!.layer.cornerRadius = 5.0
    }

    // MARK: - Table view data source
    
//    @IBAction func datePickerExpanderButton(_ sender: Any) {
//        datePickerHeight = 174
//    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 4, section: 0){
            if dateEditing == true {
                return transactionDatePicker.frame.height
            } else {
                return 0
            }
//            if editingDatePicker == true {
//                editingDatePicker = false
//                return transactionDatePicker.frame.height
//            } else {
//                editingDatePicker = true
//                return CGFloat(datePickerHeight)
//            }
        } else if indexPath == IndexPath(row: 0, section: 0){
            return CGFloat(141.0)
        } else if indexPath == IndexPath(row: 5, section: 0){
            return CGFloat(174)
        } else {
            return UITableView.automaticDimension
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath(row: 3, section: 0) {
            dateEditing = !dateEditing
            datePickerLabel.text = stringForDate(date: transactionDatePicker.date)
        }

    }
    
    func stringForDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
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
