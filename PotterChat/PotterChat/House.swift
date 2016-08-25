//
//  House.swift
//  PotterChat
//
//  Created by Emily Mearns on 7/11/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

class House: SyncableObject, CloudKitManagedObject {
    
    static let keyType = "House"
    static let keyTimestamp = "timestamp"
    
    convenience init(name: String, timestamp: NSDate = NSDate(), context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName(House.keyType, inManagedObjectContext: context) else {
            fatalError("Failed to create House entity")
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.timestamp = timestamp
        self.recordName = nameForManagedObject()
    }
    
    var recordType: String = House.keyType
    
    var cloudKitRecord: CKRecord? {
        let recordID = CKRecordID(recordName: recordName)
        let record = CKRecord(recordType: recordType, recordID: recordID)
        
        record["timestamp"] = timestamp
        record["name"] = name
        
        return record
    }
    
    convenience required init?(record: CKRecord, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let timestamp = record.creationDate, let name = record["name"] as? String else {
            print("Error creating records")
            return nil
        }
        guard let entity = NSEntityDescription.entityForName(House.keyType, inManagedObjectContext: context) else {
            fatalError()
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.timestamp = timestamp
        self.recordName = record.recordID.recordName
        self.recordIDData = NSKeyedArchiver.archivedDataWithRootObject(record.recordID)
    }
    
}
