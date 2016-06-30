//
//  HouseController.swift
//  PotterChat
//
//  Created by Emily Mearns on 6/29/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CloudKit

class HouseController {
    
    static let sharedController = HouseController()
    
    func addPostToHouse() {
        
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
    
    func subscribeToNewHouse() {
        
    }
    
    func checkSubscriptionToHouse() {
        
    }
    
    func addSubscriptionToHouse() {
        
    }
    
    func removeSubscriptionToHouse() {
        
    }
    
    func toggleHouseSubscription() {
        
    }
    
    // MARK: - Helper Functions
    
    func syncedRecords() {
        
    }
    
    func unsyncedRecords() {
        
    }
    
    func fetchNewRecords() {
        
    }
    
    func pushChangesToCloudKit() {
        
    }
    
    func performFullSync() {
        
    }
    
    
}