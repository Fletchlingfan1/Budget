//
//  Account.swift
//  Budget
//
//  Created by Jordy Vazquez on 1/23/20.
//  Copyright © 2020 Daxton Dollar. All rights reserved.
//

import Foundation
import CoreData

extension Account {
    
    convenience init?(accountAmount: Double, accountName:String, accountTotal:Double, context: NSManagedObjectContext = Stack.context){
        
        
        self.init(context: context)
        
        self.accountAmount = accountAmount
        self.accountName = accountName
        self.accountTotal = accountTotal
    }
    
}
