//
//  HogwartsViewController.swift
//  PotterChat
//
//  Created by Emily Mearns on 7/6/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class HogwartsViewController: UIViewController {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if UserController.sharedUserController.currentUser != nil {
            requestFullSync()
            updateWithHouse()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Functions
    
    func requestFullSync(completion: (() -> Void)? = nil) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        HouseController.sharedHouseController.performFullSync {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if let completion = completion {
                completion()
            }
        }
    }
    
    func updateWithHouse() {
        for house in UserController.sharedUserController.currentUser.houses {
            if house.name == HouseController.keyHogwarts {
                posts = house.posts
            }
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as? PostTableViewCell
        
        let post = posts[indexPath.row]
        cell?.updateWithPost(post)
        
        return cell ?? PostTableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
}

