//
//  Animal2TableViewCell.swift
//  group6_assignment5
//
//  Created by Raleigh Melancon on 3/1/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit

class Animal2TableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var scinameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var aclassLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
