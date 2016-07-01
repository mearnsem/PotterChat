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
        
        saveContext()
    }
    
    func addUserToHouse(user: User, houses: [House]) {
        
    }
    
    func deleteUser() {
        
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