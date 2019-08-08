//
//  Entry+Convenience.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

extension Entry { // this makes it so we don't have to initialize later/everytime we want to access these properties
    
    /// Declare our convenience initializer.  Call the memberwise initializer of Entry and initialize with our context.  Giving timestamp the a default value of 'now' (the time at which the entry is created), and context a default value.
    convenience init(title: String, body: String, timestamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.context) {
        // for memberwise
        self.init(context: context)
        // for convenience
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}
