//
//  Budget.swift
//  Budget
//
//  Created by Jordy Vazquez on 1/23/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import Foundation
import CoreData

extension Budget {
    convenience init(budgetName: String, budgetAmount: Double, context: NSManagedObjectContext = Stack.context){
        
        self.init(context:context)
        self.budgetName = budgetName
        self.budgetAmount = budgetAmount
        try? context.save()
    }
}
