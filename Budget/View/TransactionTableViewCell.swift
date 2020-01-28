//
//  TransactionTableViewCell.swift
//  Budget
//
//  Created by Jacob Mower on 1/24/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet var transactionNameTextField: UITextField!
    @IBOutlet var transactionDateTextField: UITextField!
    @IBOutlet var transactionAmountTextField: UITextField!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
