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
    
    let red = UIColor(red: 141/244, green: 0/244, blue: 0/244, alpha: 0.4)
    let yellow = UIColor(red: 242/244, green: 184/244, blue: 0/244, alpha: 0.4)
    let green = UIColor(red: 0/244, green: 84/244, blue: 22/244, alpha: 0.4)
    let blue = UIColor(red: 0/244, green: 78/244, blue: 128/244, alpha: 0.4)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        self.bgView.layer.cornerRadius = 12
        self.bgView.backgroundColor = green
    }

}
