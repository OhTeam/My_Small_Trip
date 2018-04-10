//
//  CustomTabbarItem.swift
//  MySmallTrip
//
//  Created by sungnni on 2018. 4. 5..
//  Copyright © 2018년 OhTeam. All rights reserved.
//

import UIKit

class CustomTabbarButton: UIButton {
    
    var iconImageView: UIImageView = UIImageView()
    var underline: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame: CGRect, image: String) {
        self.init(frame: frame)
        
        updateLayout()
        iconImageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.Custom.greyColor
        
        underline.backgroundColor = UIColor.Custom.mainColor
        underline.alpha = 0
        
        self.addSubview(iconImageView)
        self.addSubview(underline)
    }
    
    
    
    func updateLayout() {
        // imageView Frame
        let iconSize: CGFloat = 24
        let centerX = (self.frame.width - iconSize) / 2
        let centerY = (self.frame.height - iconSize) / 2
        iconImageView.frame = CGRect(x: centerX, y: centerY, width: iconSize, height: iconSize)
        
        // underline Frame
        let underlineX: CGFloat = 16
        let underlineWidth = self.frame.width - underlineX * 2
        let underlineHeight: CGFloat = 4
        let underlineY = self.frame.height - underlineHeight
        
        underline.frame = CGRect(x: underlineX, y: underlineY, width: underlineWidth, height: underlineHeight)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
