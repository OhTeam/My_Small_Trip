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

        self.view.backgroundColor = UIColor.Custom.backgroundColor
        
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 106, height: 33))

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 106, height: 33))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo(small)")
        imageView.image = image
        logoContainer.addSubview(imageView)

        for idx in 0..<self.childViewControllers.count {

            self.childViewControllers[idx].navigationItem.titleView = logoContainer
        }
        
        
        
        self.navigationBar.frame.size = self.navigationBar.sizeThatFits(CGSize(width: self.navigationBar.frame.size.width, height: 84))
        
//        let height: CGFloat = 50
//        self.navigationBar.frame = CGRect(x: 0, y: 0, width: self.navigationBar.frame.width, height: height + self.navigationBar.frame.height)
        
//        self.navigationBar.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: 56))
        
//        self.navigationBar.sizeThatFits(CGSize(width: 0, height: 0))
        
        
        
//        let logo = UIImage(named: "logo(small)")
//
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 106, height: 33))
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = logo
//
//
//        for idx in 0..<self.childViewControllers.count {
//
//            self.childViewControllers[idx].navigationItem.titleView = imageView
//        }
        
    }

}


// 커스텀 내비게이션 바
class CustomNavigationBar: UINavigationBar {
    
    //set NavigationBar's height
    
    
    
    // 내비 바 height 조절
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var customHeight: CGFloat = 84
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.barTintColor = UIColor.Custom.backgroundColor

        var customHeight: CGFloat = 100
        
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
