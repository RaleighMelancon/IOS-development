//
//  BudgetCell.swift
//  Moneyball
//
//  Created by Hughes, Brady L on 4/23/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit

class BudgetCell: UITableViewCell {
    @IBOutlet weak var expenseName: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
