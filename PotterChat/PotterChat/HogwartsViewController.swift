//
//  HogwartsViewController.swift
//  PotterChat
//
//  Created by Emily Mearns on 7/6/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class HogwartsViewController: UIViewController, TextFieldViewControllerDelegate, UIScrollViewDelegate {
    
    var posts = [Post]()
    var textFieldVC: TextFieldViewController?
    
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.textFieldVC?.resignTextFieldFirstResponder()
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
    
    // MARK: - Textfield Protocol
    
    func postPost(text: String) {
        
        for hogwarts in HouseController.sharedHouseController.housesArray {
            if hogwarts.name == "Hogwarts" {
                HouseController.sharedHouseController.addPostToHouse(text, house: hogwarts, user: UserController.sharedUserController.currentUser)
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCellHogwarts", forIndexPath: indexPath) as? PostTableViewCell
        
        let post = posts[indexPath.row]
        cell?.updateWithPost(post)
        
        return cell ?? PostTableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toContainerFromHogwarts" {
            if let embedViewController = segue.destinationViewController as? TextFieldViewController {
                embedViewController.delegate = self
                self.textFieldVC = embedViewController
            }
        }
    }
}



