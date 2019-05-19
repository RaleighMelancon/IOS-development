//
//  PushButton.swift
//  Moneyball
//
//  Created by Raleigh Melancon on 4/30/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//
import UIKit
import CoreGraphics
@IBDesignable
class PushButton: UIButton {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.topLeft, .bottomRight],
                                cornerRadii: CGSize(width: 20.0, height: 0.0))
        
        let forestGreen = MONEY_GREEN
        forestGreen.setFill()
        path.fill()
        
    }
    
}
