//
//  Extension.swift
//  MySmallTrip
//
//  Created by sungnni on 2018. 4. 4..
//  Copyright © 2018년 OhTeam. All rights reserved.
//

import UIKit

extension UIColor {
    struct Custom {
        static let mainColor = UIColor.rgb(red: 242, green: 92, blue: 98)
        static let greyColor = UIColor.rgb(red: 174, green: 174, blue: 174)
        static let backgroundColor = UIColor.rgb(red: 247, green: 247, blue: 247)
    }
    
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
