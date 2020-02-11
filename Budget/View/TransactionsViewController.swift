//
//  TransactionsViewController.swift
//  Budget
//
//  Created by Jacob Mower on 1/24/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetTotalLabel: UILabel!
    
    var budgetName: String?
    var budgetTotal: Double?
    var currencyFormater = NumberFormatter()


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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
