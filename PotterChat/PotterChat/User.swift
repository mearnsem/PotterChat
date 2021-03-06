//
//  User.swift
//  PotterChat
//
//  Created by Emily Mearns on 7/1/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

class User: SyncableObject, CloudKitManagedObject {

    static let keyType = "User"
    
    convenience init(username: String, houses: [House], timestamp: NSDate = NSDate(), context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName(User.keyType, inManagedObjectContext: context) else {
            fatalError("Failed to create User entity")
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.username = username
        self.houses = NSSet(array: houses)
        self.timestamp = timestamp
        self.recordName = self.nameForManagedObject()
    }
    
    var recordType: String = User.keyType
    
    var cloudKitRecord: CKRecord? {
        let recordID = CKRecordID(recordName: recordName)
        let record = CKRecord(recordType: recordType, recordID: recordID)
        
        record["username"] = username
        record["timestamp"] = timestamp
        
        return record
    }
    
    convenience required init?(record: CKRecord, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let timestamp = record.creationDate else {return nil}
        guard let entity = NSEntityDescription.entityForName(User.keyType, inManagedObjectContext: context) else {fatalError()}
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.timestamp = timestamp
        self.recordName = record.recordID.recordName
        self.recordIDData = NSKeyedArchiver.archivedDataWithRootObject(record.recordID)
    }

}
