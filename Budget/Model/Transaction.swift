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
    
    convenience init?(transactionAmount: Double, transactionName:String, transactionNotes:String, transactionDate:Date, context: NSManagedObjectContext = Stack.context){
        self.init(context: context)
        
        self.transactionAmount = transactionAmount
        self.transactionName = transactionName
        self.transactionNotes = transactionNotes
        self.transactionDate = transactionDate
    }
}
