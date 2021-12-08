//
//  DataController.swift
//  Virtual Tourist
//
//  Created by Ruslan Ismayilov on 11/15/21.
//

import Foundation
import CoreData

class DataController {
    let persistentContainer : NSPersistentContainer
    
    
    var viewContext : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName : String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion : (() -> Void)? = nil){
        persistentContainer.loadPersistentStores { storeDescriptor, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
        
    }
}
