//
//  UI Color Extension.swift
//  Organise
//
//  Created by Bryan Ye on 2/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit

extension UIColor {

    static func organiseRedColor() -> UIColor {
    //Hex value: E62739
        
    return UIColor(red:230/255.0, green:39/255.0, blue:57/255.0, alpha: 1)
    }
    
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

}