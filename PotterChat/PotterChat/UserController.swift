//
//  UserController.swift
//  PotterChat
//
//  Created by Emily Mearns on 6/29/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation

class UserController {
    
    static let sharedUserController = UserController()
    let cloudKitManager = CloudKitManager()
    
    func createUser(username: String) {
        let _ = User(username: username)
        saveContext()
    }
    
    func addUserToHouses(user: User, houses: [House]) {
        user.houses = [houses[0], houses[1]]
        if let userRecord = user.cloudKitRecord {
            cloudKitManager.saveRecord(userRecord, completion: { (record, error) in
                if let record = record {
                    user.update(record)
                }
            })
        }
    }
    
    func deleteUser(user: User) {
        
    }
    
    func getUserForHouse() {
        
    }
    
    func saveContext() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("The User could not be saved")
        }
    }
    
}