//
//  MainNavigationController.swift
//  MySmallTrip
//
//  Created by sungnni on 2018. 4. 5..
//  Copyright © 2018년 OhTeam. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.Custom.greyColor
        
        
        // logo image layout update
        let width: CGFloat = 106
        let height: CGFloat = 33
        
        let x = self.navigationBar.center.x - (width / 2)
        let y = self.navigationBar.center.y - (height / 2)
        
        let logoContainer = UIView(frame: CGRect(x: 0, y: 10, width: width, height: height))

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo(small)")
        imageView.image = image
        logoContainer.addSubview(imageView)

        for idx in 0..<self.childViewControllers.count {

            self.childViewControllers[idx].navigationItem.titleView = logoContainer
        }
    }

}


// 커스텀 내비게이션 바
class CustomNavigationBar: UINavigationBar {
    
    //set NavigationBar's height
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.barTintColor = UIColor.Custom.backgroundColor

        var customHeight: CGFloat = 56
        
        
        frame = CGRect(x: frame.origin.x, y: 0, width: frame.size.width, height: customHeight)

        // title position (statusbar height / 2)
        setTitleVerticalPositionAdjustment(-10, for: UIBarMetrics.default)

        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                subview.backgroundColor = UIColor.Custom.backgroundColor

            }

            stringFromClass = NSStringFromClass(subview.classForCoder)

            if stringFromClass.contains("BarContent") {

                subview.frame = CGRect(x: subview.frame.origin.x, y: 20, width: subview.frame.width, height: customHeight - 20)
            }
        }
    }
}
