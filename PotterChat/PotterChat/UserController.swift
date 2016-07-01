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
    
    func createUser(username: String) {
        let _ = User(username: username)
        saveContext()
    }
    
    func addUserToHouse(user: User) {
        
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