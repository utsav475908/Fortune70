//
//  CustomButton.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 05/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable   var cornerRadiusValue:CGFloat = 10.0 {
        didSet {
           setUpView()  
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        self.clipsToBounds = true
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
