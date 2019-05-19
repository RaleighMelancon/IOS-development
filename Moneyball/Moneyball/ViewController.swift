//
//  ViewController.swift
//  Moneyball
//
//  Created by Hughes, Brady L on 4/17/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
   
    let pieChart = PieChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let padding: CGFloat = 10
        let height = (view.frame.height - padding) / 2
        
        pieChart.frame = CGRect(
            x: 0, y: 0, width: view.frame.size.width, height: height
        )
        
        pieChart.segments = [
            Segment(color: #colorLiteral(red: 0.4682564139, green: 0.03185952082, blue: 0.1033824906, alpha: 1), name: "Food",  value: CGFloat(foodcount)),
            Segment(color: #colorLiteral(red: 0.7174351811, green: 0.2240640521, blue: 0.1049374416, alpha: 1), name: "Entertainment",     value: CGFloat(entertainmentcount)),
            Segment(color: #colorLiteral(red: 0.2989701331, green: 0.2074568868, blue: 0.4651491642, alpha: 1), name: "Rent",  value: CGFloat(rentcount)),
            Segment(color: #colorLiteral(red: 0.1664952636, green: 0.5884919167, blue: 0.8048949242, alpha: 1), name: "Utilites", value: CGFloat(utilitiescount)),
            Segment(color: #colorLiteral(red: 0.1934762299, green: 0.2189904749, blue: 0.4976225495, alpha: 1), name: "Transportation",   value: CGFloat(transportationcount)),
        ]
        
        pieChart.segmentLabelFont = .systemFont(ofSize: 35)
        
        view.addSubview(pieChart)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

