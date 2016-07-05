//
//  PostTableViewCell.swift
//  PotterChat
//
//  Created by Emily Mearns on 6/30/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    let gryffindorRed = UIColor(red: 141/244, green: 0/244, blue: 0/244, alpha: 0.4)
    let hufflepuffYellow = UIColor(red: 242/244, green: 184/244, blue: 0/244, alpha: 0.4)
    let ravenclawBlue = UIColor(red: 0/244, green: 78/244, blue: 128/244, alpha: 0.4)
    let slytherinGreen = UIColor(red: 0/244, green: 84/244, blue: 22/244, alpha: 0.4)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        self.bgView.layer.cornerRadius = 12
    }
    
    func updateWithPost(post: Post) {
        usernameLabel.text = post.user.username
        timeLabel.text = post.timestamp.stringValue()
        
        for house in UserController.sharedUserController.currentUser.houses {
            if house.name == HouseController.keyGryffindor {
                self.bgView.backgroundColor = gryffindorRed
            }
            if house.name == HouseController.keyHufflepuff {
                self.bgView.backgroundColor = hufflepuffYellow
            }
            if house.name == HouseController.keyRavenclaw {
                self.bgView.backgroundColor = ravenclawBlue
            }
            if house.name == HouseController.keySlytherin {
                self.bgView.backgroundColor = slytherinGreen
            }
        }
    }

}
