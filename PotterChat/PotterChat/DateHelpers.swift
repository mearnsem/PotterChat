//
//  DateHelpers.swift
//  Task
//
//  Created by Emily Mearns on 5/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

extension NSDate {
    func stringValue() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        
        return formatter.stringFromDate(self)
    }
}