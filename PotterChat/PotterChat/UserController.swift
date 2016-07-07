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
    
    var currentUser: User! {
        let fetchRequest = NSFetchRequest(entityName: "User")
        var user: User!
        do {
            let users = try Stack.sharedStack.managedObjectContext.executeFetchRequest(fetchRequest) as! [User]
            user = users.first ?? nil
        } catch {
            return User()
        }
        return user ?? nil
    }
    
    func createUser(username: String, house: House) -> User {
        
        var houses: [House] = []
        
        for hogwarts in HouseController.sharedHouseController.housesArray {
            if hogwarts.name == "Hogwarts" {
                houses = [house, hogwarts]
            }
        }
        
        
        let user = User(username: username, houses: houses)
        saveContext()
        return user
    }
    
    func deleteUser(user: User) {
        
    }
    
    func getUserForHouse() {
        
    }
    
    func saveContext() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch let error as NSError {
            print("The User could not be saved. Error: \(error.localizedDescription) --> \(#function)")
        }
    }
    
}