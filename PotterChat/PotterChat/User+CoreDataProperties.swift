//
//  User+CoreDataProperties.swift
//  PotterChat
//
//  Created by Emily Mearns on 7/1/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var username: String
    @NSManaged var houses: NSSet
    @NSManaged var posts: NSSet?

}
