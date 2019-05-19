//
//  WeekCell.swift
//  Moneyball
//
//  Created by Hughes, Brady L on 4/25/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit

class WeekCell: UITableViewCell {
    @IBOutlet weak var weekid: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var spent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
