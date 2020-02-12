//
//  TransactionTableViewCell.swift
//  Budget
//
//  Created by Jacob Mower on 1/24/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet var transactionNameTextField: UILabel!
    @IBOutlet var transactionDateTextField: UILabel!
    @IBOutlet var transactionAmountTextField: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with transaction: Transactions) {
        
        transactionNameTextField.text = transaction.transactionName
        transactionDateTextField.text = BudgetController.sharedController.stringForDate(date: transaction.transactionDate)
        transactionAmountTextField.text = "\(transaction.transactionAmount)"
    }
    
}
