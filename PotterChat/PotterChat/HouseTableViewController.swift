//
//  HouseTableViewController.swift
//  PotterChat
//
//  Created by Emily Mearns on 6/30/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class HouseTableViewController: UITableViewController {
    
    @IBOutlet weak var houseCrestImageView: UIImageView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewWithHouse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Functions
    
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

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("houseCell", forIndexPath: indexPath) as? PostTableViewCell

        let post = posts[indexPath.row]
        cell?.updateWithPost(post)

        return cell ?? PostTableViewCell()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
