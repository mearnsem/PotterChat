//
//  Post.swift
//  PotterChat
//
//  Created by Emily Mearns on 6/30/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

class Post: SyncableObject, CloudKitManagedObject {

    static let keyType = "Post"
    static let keyTimestamp = "timestamp"
    static let keyText = "text"
    
    convenience init(text: String, house: House, user: User, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName(Post.keyType, inManagedObjectContext: context) else {
            fatalError("Failed to create Post entity")
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.text = text
        self.house = house
        self.user = user
        self.timestamp = timestamp
        self.recordName = self.nameForManagedObject()
    }
    
    // MARK: - CKMO
    
    var recordType: String = Post.keyType
    
    var cloudKitRecord: CKRecord? {
        let recordID = CKRecordID(recordName: recordName)
        let record = CKRecord(recordType: recordType, recordID: recordID)
        
        record[Post.keyTimestamp] = timestamp
        return record
    }
    
    convenience required init?(record: CKRecord, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let timestamp = record.creationDate else {return nil}
        guard let entity = NSEntityDescription.entityForName(Post.keyType, inManagedObjectContext: context) else {
            fatalError()
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.timestamp = timestamp
        self.recordName = record.recordID.recordName
        self.recordIDData = NSKeyedArchiver.archivedDataWithRootObject(record.recordID)
    }

}




