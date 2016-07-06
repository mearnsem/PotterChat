//
//  UserController.swift
//  PotterChat
//
//  Created by Emily Mearns on 6/29/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    
    static let sharedUserController = UserController()
    let cloudKitManager = CloudKitManager()
    
    var currentUser: User {
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        do {
             let users = try Stack.sharedStack.managedObjectContext.executeFetchRequest(fetchRequest) as! [User]
            return users.first!
        } catch {
            return User()
        }
    }
    
    func createUser(username: String) -> User {
        let user = User(username: username)
        saveContext()
        return user
    }
    
    func addUserToHouses(user: User, house: House) {
        user.houses = [house, HouseController.sharedHouseController.hogwarts]
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