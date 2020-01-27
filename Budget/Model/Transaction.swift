//
//  Transaction.swift
//  Budget
//
//  Created by Jordy Vazquez on 1/22/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import Foundation
import CoreData

extension Transactions {
    
    convenience init?(transactionAmount: Double, transactionName:String, notes:String, date:Date, context: NSManagedObjectContext = Stack.context){
        self.init(context: context)
        
        self.transactionAmount = transactionAmount
        self.transactionName = transactionName
        self.notes = notes
        self.date = date
    }
}
