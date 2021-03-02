//
//  extension+UIColor.swift
//  Kripto
//
//  Created by Hüseyin Yalçınlar on 4.02.2021.
//  Copyright © 2021 Hüseyin Yalçınlar. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgbDonustur( red : CGFloat, green: CGFloat, blue : CGFloat )-> UIColor{
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}
