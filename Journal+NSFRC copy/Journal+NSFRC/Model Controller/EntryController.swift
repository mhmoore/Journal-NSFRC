//
//  EntryController.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let sharedInstance = EntryController()
    
//    /// Entries is a computed property.  Its getting its value from the results of a NSFetchRequest.  The <Model> defines the generic type.  This ensures that our entries array can ONLY hold Entry Objects.
//    var entries: [Entry] {
//        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
//        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
//    }
    
    // this local variable allows us to access the fetched results
    var fetchedResultsController: NSFetchedResultsController<Entry>
    
    // NSFRC
    init() {
        // creates a fetch request
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        /// sorts in descending based upon the key (which are the attributes defined in the data model. can add multiple sort descriptors in order of preference)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false), NSSortDescriptor(key: "title", ascending: true)]
        
        // creates a result controller of type NSFetchedResultsController tha only interacts with Entry data, and initializes it
        let resultsController: NSFetchedResultsController<Entry> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        
        // actually performs the fetch
        do{
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch! \(#function) \(error.localizedDescription)")
        }
    }
    
    //CRUD
    /// We define a createEntry method that takes in two strings: Title, and body.  Then we are using convenience initializer we extended the Entry Class with and pass in those strings. This creates our Entry Objects with all required data
    func createEntry(withTitle: String, withBody: String) {
        let _ = Entry(title: withTitle, body: withBody)
        
        saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        
        saveToPersistentStore()
    }
    
    func deleteEntry(entry: Entry) {
        entry.managedObjectContext?.delete(entry)
        
        saveToPersistentStore()
    }
    
    /// 'attempting' to save all our Entry Data to our CoreDataStack(s) Persistent Store
    func saveToPersistentStore() {
        do {
             try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object. Items not saved!! \(#function) : \(error.localizedDescription)")
        }
    }
}
