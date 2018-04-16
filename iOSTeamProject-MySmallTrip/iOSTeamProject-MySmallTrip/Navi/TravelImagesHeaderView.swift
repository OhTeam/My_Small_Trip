//
//  TravelImageHeaderViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 16..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class TravelImagesHeaderView: UIView {
    @IBOutlet private weak var pageControl: UIPageControl!
    
    
}

extension TravelImagesHeaderView: TravelImagesPageViewControllerDelegate {
    func setUpPageController(numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }
    
    func turnPageController(to index: Int) {
        pageControl.currentPage = index
    }
}
