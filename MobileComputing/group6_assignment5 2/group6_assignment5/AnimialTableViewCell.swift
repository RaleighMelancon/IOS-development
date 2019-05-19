//
//  AnimialTableViewCell.swift
//  group6_assignment5
//
//  Created by Raleigh Melancon on 3/1/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var commonAnimalNameLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
