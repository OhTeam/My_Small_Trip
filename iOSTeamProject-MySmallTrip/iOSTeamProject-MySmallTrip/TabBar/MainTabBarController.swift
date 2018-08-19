//
//  MainTabBarController.swift
//  MySmallTrip
//
//  Created by sungnni on 2018. 4. 4..
//  Copyright © 2018년 OhTeam. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    // safeGuideLine
    private var safeGuide: UILayoutGuide?
    
    // 탭바 View
    var barView = UIView()
    
    // 탭바 아이템 개수 (홈, 서치, 위시리스트, 프로필)
    var itemCount: Int = 4
    var tabItemList: [CustomTabbarButton] = []
    
    // 탭바 아이템 이미지 String
    let iconList = ["tabBarItem01Home", "tabBarItem02Search", "tabBarItem03Wishlist", "tabBarItem04Profile"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isHidden = false
        
        tabbarLayout()
        makeTabbarItem()
        
//         첫번째 탭바 뷰 고정
        self.onTabBarItemClick(tabItemList[0])
    }

    
    // barView(탭바) 레이아웃
    func tabbarLayout() {
        // custom tabbar layout
        let width = self.view.frame.size.width
        let height: CGFloat = self.tabBar.frame.height
        let x: CGFloat = 0
        let y = self.tabBar.frame.origin.y
        
        barView.frame = CGRect(x: x, y: y, width: width, height: height)
        barView.backgroundColor = UIColor.white
        self.view.addSubview(barView)
        
        barView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(barView)
        
        // autoLayout
        safeGuide = self.view.safeAreaLayoutGuide
        barView.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        barView.bottomAnchor.constraint(equalTo: safeGuide!.bottomAnchor).isActive = true
        barView.leadingAnchor.constraint(equalTo: safeGuide!.leadingAnchor).isActive = true
        barView.trailingAnchor.constraint(equalTo: safeGuide!.trailingAnchor).isActive = true
    }
    
    
    // 탭바 안에 들어가는 아이템(커스텀 버튼) 레이아웃
    func makeTabbarItem() {
        let tabbarItemWidth = self.view.frame.width / CGFloat(itemCount)
        let tabbarItemHeight = self.barView.frame.size.height
        
        for idx in 0..<itemCount {
            
            let frame = CGRect(x: tabbarItemWidth * CGFloat(idx),
                                     y: 0,
                                     width: tabbarItemWidth,
                                     height: tabbarItemHeight)
            
            let customBtn = CustomTabbarButton(frame: frame, image: iconList[idx])
            
            customBtn.tag = idx
            customBtn.addTarget(self, action: #selector(onTabBarItemClick(_:)), for: .touchUpInside)
            
            barView.addSubview(customBtn)
            tabItemList.append(customBtn)
        }
    }
    
    
    
    var temp = 0
    @objc func onTabBarItemClick(_ sender: CustomTabbarButton) {
        // 탭바 컨트롤러 인덱스 뷰를 버튼의 태그값으로 전달
        self.selectedIndex = sender.tag
        
        // 선택된 탭바 tintColor 변경 (image / underline)
        if sender.tag != temp {
            tabItemList[temp].iconImageView.tintColor = UIColor.Custom.greyColor
            tabItemList[temp].underline.alpha = 0
            
            sender.iconImageView.tintColor = UIColor.Custom.mainColor
            sender.underline.alpha = 1
            
            temp = sender.tag
        } else {
            // 탭바 로드됐을 때, 첫 item에 tint color 적용
            sender.iconImageView.tintColor = UIColor.Custom.mainColor
            sender.underline.alpha = 1
        }
    }
    
}
