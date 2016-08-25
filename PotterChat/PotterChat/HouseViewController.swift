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
    
    var posts: [Post] = []
    var textFieldVC: TextFieldViewController?
    
    @IBOutlet weak var houseTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        houseTableview.reloadData()
        houseTableview.separatorColor = .clearColor()
        
        if UserController.sharedUserController.currentUser != nil {
            requestFullSync()
            updateWithHouse()
        }
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
            if house.name == HouseController.keyGryffindor {
                houseCrestImageView.image = UIImage(named: "crestGryff")
                let sortedPosts = house.posts.sort{$0.timestamp.timeIntervalSince1970 > $1.timestamp.timeIntervalSince1970}
                posts = sortedPosts
            }
            if house.name == HouseController.keyHufflepuff {
                houseCrestImageView.image = UIImage(named: "crestHuff")
                let sortedPosts = house.posts.sort{$0.timestamp.timeIntervalSince1970 > $1.timestamp.timeIntervalSince1970}
                posts = sortedPosts
            }
            if house.name == HouseController.keyRavenclaw {
                houseCrestImageView.image = UIImage(named: "crestRaven")
                let sortedPosts = house.posts.sort{$0.timestamp.timeIntervalSince1970 > $1.timestamp.timeIntervalSince1970}
                posts = sortedPosts
            }
            if house.name == HouseController.keySlytherin {
                houseCrestImageView.image = UIImage(named: "crestSly")
                let sortedPosts = house.posts.sort{$0.timestamp.timeIntervalSince1970 > $1.timestamp.timeIntervalSince1970}
                posts = sortedPosts
            }
        }
    }
    
    // MARK: - Textfield Protocol
    
    func postPost(text: String) {
        let user = UserController.sharedUserController.currentUser
        
        for house in UserController.sharedUserController.currentUser.houses {
            if house.name == HouseController.keyGryffindor {
                HouseController.sharedHouseController.addPostToHouse(text, house: house as! House, user: user)
            }
            if house.name == HouseController.keyHufflepuff {
                HouseController.sharedHouseController.addPostToHouse(text, house: house as! House, user: user)
            }
            if house.name == HouseController.keyRavenclaw {
                HouseController.sharedHouseController.addPostToHouse(text, house: house as! House, user: user)
            }
            if house.name == HouseController.keySlytherin {
                HouseController.sharedHouseController.addPostToHouse(text, house: house as! House, user: user)
            }
        }
        
        updateWithHouse()
        houseTableview.reloadData()
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







