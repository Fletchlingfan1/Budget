//
//  BudgetTableViewCell.swift
//  Budget
//
//  Created by Jacob Mower on 1/22/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {

    @IBOutlet var budgetNameTextField: UITextField!
    @IBOutlet var budgetAmountTextField: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with budget: Budget) {
        budgetNameTextField.text = budget.budgetName
        budgetAmountTextField.text = "\(budget.budgetAmount)"
    }

}
