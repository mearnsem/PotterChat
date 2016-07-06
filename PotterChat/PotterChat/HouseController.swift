//
//  HouseController.swift
//  PotterChat
//
//  Created by Emily Mearns on 6/29/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

class HouseController {
    
    static let sharedHouseController = HouseController()
    let cloudKitManager: CloudKitManager
    var isSyncing: Bool = false
    
    static let keyGryffindor = "Gryffindor"
    static let keyHufflepuff = "Hufflepuff"
    static let keyRavenclaw = "Ravenclaw"
    static let keySlytherin = "Slytherin"
    static let keyHogwarts = "Hogwarts"
    
    let hogwarts = House(color: "black", name: HouseController.keyHogwarts)
    let gryffindor = House(color: "gryffindorRed", name: HouseController.keyGryffindor)
    let hufflepuff = House(color: "hufflepuffYellow", name: HouseController.keyHufflepuff)
    let ravenclaw = House(color: "ravenclawBlue", name: HouseController.keyRavenclaw)
    let slytherin = House(color: "slytherinGreen", name: HouseController.keySlytherin)
    
    init() {
        cloudKitManager = CloudKitManager()
    }
    
    func addPostToHouse(text: String, house: House, user: User) {
        let post = Post(text: text, house: house, user: user)
        saveContext()
        
        if let postRecord = post.cloudKitRecord {
            cloudKitManager.saveRecord(postRecord, completion: { (record, error) in
                if let record = record {
                    post.update(record)
                }
            })
        }
    }
    
    func deletePostFromHouse() {
        
    }
    
    func getPostsForHouse() {
        
    }
    
    func saveContext() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Failed to save context")
        }
        
    }
    
    // MARK: - Subscriptions
    
    func subscribeToNewHouse(completion: ((success: Bool, error: NSError?) -> Void)?) {
        let predicate = NSPredicate(value: true)
        
        cloudKitManager.subscribe(House.keyType, predicate: predicate, subscriptionID: "allPosts", contentAvailable: true, options: .FiresOnRecordCreation) { (subscription, error) in
            if let completion = completion {
                let success = subscription != nil
                completion(success: success, error: error)
            }
        }
    }
    
    func checkSubscriptionToHouse(house: House, completion: ((subscribed: Bool) -> Void)?) {
        cloudKitManager.fetchSubscription(house.recordName) { (subscription, error) in
            if let completion = completion {
                let subscribed = subscription != nil
                completion(subscribed: subscribed)
            }
        }
    }
    
    func addSubscriptionToHouse(house: House, alertBody: String?, completion: ((success: Bool, error: NSError?) -> Void)?) {
        guard let recordID = house.cloudKitRecord else {
            fatalError("Unable to create CloudKit Reference for subscription.")
        }
        let predicate = NSPredicate(format: "post == @", argumentArray: [recordID])
        
        cloudKitManager.subscribe(House.keyType, predicate: predicate, subscriptionID: house.recordName, contentAvailable: true, alertBody: alertBody, desiredKeys: [House.keyType], options: .FiresOnRecordCreation) { (subscription, error) in
            if let completion = completion {
                let success = subscription != nil
                completion(success: success, error: error)
            }
        }
    }
    
    func removeSubscriptionToHouse(house: House, completion: ((success: Bool, error: NSError?) -> Void)?) {
        let subscriptionID = house.recordName
        
        cloudKitManager.unsubscribe(subscriptionID) { (subscriptionID, error) in
            if let completion = completion {
                let success = subscriptionID != nil && error != nil
                completion(success: success, error: error)
            }
        }
    }
    
    func toggleHouseSubscription(house: House, completion: ((success: Bool, isSubscribed: Bool, error: NSError?) -> Void)?) {
        cloudKitManager.fetchSubscriptions { (subscriptions, error) in
            if subscriptions?.filter({$0.subscriptionID == house.recordName}).first != nil {
                self.removeSubscriptionToHouse(house, completion: { (success, error) in
                    if let completion = completion {
                        completion(success: success, isSubscribed: false, error: error)
                    }
                })
            } else {
                self.addSubscriptionToHouse(house, alertBody: "Someone posted in your House Common Room", completion: { (success, error) in
                    if let completion = completion {
                        completion(success: success, isSubscribed: true, error: error)
                    }
                })
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func syncedRecords(type: String) -> [CloudKitManagedObject] {
        let fetchRequest = NSFetchRequest(entityName: type)
        let predicate = NSPredicate(format: "recordIDData != nil")
        fetchRequest.predicate = predicate
        
        let results = (try? Stack.sharedStack.managedObjectContext.executeFetchRequest(fetchRequest)) as? [CloudKitManagedObject] ?? []
        return results
    }
    
    func unsyncedRecords(type: String) -> [CloudKitManagedObject] {
        let fetchRequest = NSFetchRequest(entityName: type)
        let predicate = NSPredicate(format: "recordIDData = nil")
        fetchRequest.predicate = predicate
        
        let results = (try? Stack.sharedStack.managedObjectContext.executeFetchRequest(fetchRequest)) as? [CloudKitManagedObject] ?? []
        return results
    }
    
    func fetchNewRecords(type: String, completion: (()-> Void)?) {
        let references = syncedRecords(type).flatMap({$0.cloudKitReference})
        var predicate = NSPredicate(format: "NOT(recordID IN %@)", argumentArray: [references])
        
        if references.isEmpty {
            predicate = NSPredicate(value: true)
        }
        
        cloudKitManager.fetchRecordsWithType(type, predicate: predicate, recordFetchedBlock: { (record) in
            switch type {
            case House.keyType:
                let _ = House(record: record)
            default:
                return
            }
            self.saveContext()
        }) { (records, error) in
            if error != nil {
                print("Error: \(error?.localizedDescription) --> \(#function)")
            }
        }
    }
    
    func pushChangesToCloudKit(completion: ((success: Bool, error: NSError?) -> Void)?) {
        let unsavedManagedObjects = unsyncedRecords(House.keyType)
        let unsavedRecords = unsavedManagedObjects.flatMap({$0.cloudKitRecord})
        
        cloudKitManager.saveRecords(unsavedRecords, perRecordCompletion: { (record, error) in
            guard let record = record else {return}
            if let matchingRecord = unsavedManagedObjects.filter({$0.recordName == record.recordID.recordName}).first {
                matchingRecord.update(record)
            }
        }) { (records, error) in
            if let completion = completion {
                let success = records != nil
                completion(success: success, error: error)
            }
        }
    }
    
    func performFullSync(completion: (()-> Void)? = nil) {
        if isSyncing {
            if let completion = completion {
                completion()
            }
        } else {
            isSyncing = true
            
            pushChangesToCloudKit({ (success, error) in
                self.fetchNewRecords(House.keyType, completion: {
                    self.isSyncing = false
                    if let completion = completion {
                        completion()
                    }
                })
            })
        }
    }
}








