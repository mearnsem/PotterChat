//
//  HouseViewController.swift
//  PotterChat
//
//  Created by Emily Mearns on 7/6/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class HouseViewController: UIViewController, TextFieldViewControllerDelegate, UIScrollViewDelegate {

    @IBOutlet weak var houseCrestImageView: UIImageView!
    
    var posts = [Post]()
    var textFieldVC: TextFieldViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestFullSync()
        updateViewWithHouse()
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
    
    func updateViewWithHouse() {
        for house in UserController.sharedUserController.currentUser.houses {
            if house.name == HouseController.keyGryffindor {
                houseCrestImageView.image = UIImage(named: "crestGryff")
                posts = house.posts
            }
            if house.name == HouseController.keyHufflepuff {
                houseCrestImageView.image = UIImage(named: "crestHuff")
                posts = house.posts
            }
            if house.name == HouseController.keyRavenclaw {
                houseCrestImageView.image = UIImage(named: "crestRaven")
                posts = house.posts
            }
            if house.name == HouseController.keySlytherin {
                houseCrestImageView.image = UIImage(named: "crestSly")
                posts = house.posts
            }
        }
        
    }
    
    // MARK: - Textfield Protocol
    
    func postPost(text: String) {
        for house in HouseController.sharedHouseController.housesArray {
            if house.name == "Gryffindor" {
                HouseController.sharedHouseController.addPostToHouse(text, house: house, user: UserController.sharedUserController.currentUser)
            }
            if house.name == "Hufflepuff" {
                HouseController.sharedHouseController.addPostToHouse(text, house: house, user: UserController.sharedUserController.currentUser)
            }
            if house.name == "Ravenclaw" {
                HouseController.sharedHouseController.addPostToHouse(text, house: house, user: UserController.sharedUserController.currentUser)
            }
            if house.name == "Slytherin" {
                HouseController.sharedHouseController.addPostToHouse(text, house: house, user: UserController.sharedUserController.currentUser)
            }
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCellHouse", forIndexPath: indexPath) as? PostTableViewCell
        
        let post = posts[indexPath.row]
        cell?.updateWithPost(post)
        
        return cell ?? PostTableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toContainerFromHouse" {
            if let embedViewController = segue.destinationViewController as? TextFieldViewController {
                embedViewController.delegate = self
                self.textFieldVC = embedViewController
            }
        }
    }

}







