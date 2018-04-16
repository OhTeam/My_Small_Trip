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
        setNavigationItemTitleView()
    }
    
    private func setNavigationItemTitleView() {
        
        // logo image layout update
        let width: CGFloat = 90
        let height: CGFloat = 26
        
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        imageView.image = UIImage(named: "logo(small)")
        logoContainer.addSubview(imageView)
        
        
        // navigagtion Controller의 childViewControllers의 titleView 설정
        for idx in 0..<self.childViewControllers.count {
            self.childViewControllers[idx].navigationItem.titleView = logoContainer
        }
        
        
        /***************************************************
         <study.>
         -. logoContainer는 navigationItem.titleView이기 때문에 (x, y) 좌표값 상관 X
         -. logoContainer의 subView인 imageView는 (x, y) 좌표값대로 위치 가능
         -. 컨테이너 뷰 없이 바로 navigationItem.titleView = imageView로 설정하면
         width / height 값 설정 상관 없이 value fix 돼서 load
         ***************************************************/
    }
}
