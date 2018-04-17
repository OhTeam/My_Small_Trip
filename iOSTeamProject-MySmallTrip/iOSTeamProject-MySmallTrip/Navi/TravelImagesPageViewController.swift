//
//  TravelImagesPageViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 15..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

protocol TravelImagesPageViewControllerDelegate:
    class
{
    func setUpPageController(numberOfPages: Int)
    func turnPageController(to index: Int)
}


class TravelImagesPageViewController: UIPageViewController {
 
    var images: [TravelImage]?
    weak var pageViewControllerDelegate: TravelImagesPageViewControllerDelegate?
    
    struct Storyboard {
        static let travelImageViewController = "TravelImageViewController"
    }
    
    lazy var controllers: [UIViewController] = {
        print("\n---------- [ lazy var controllers: [UIViewController] = { ] -----------\n")
        let storyboard = UIStoryboard(name: "Root", bundle: nil)
        var controllers = [UIViewController]()
        
        // 이미지의 개수만큼 이미지 뷰컨트롤러를 controllers 배열에 추가
        if let images = self.images {
            print("이게 안돼냐")
            for image in images {
                let travelImageVC = storyboard.instantiateViewController(withIdentifier: Storyboard.travelImageViewController)
                controllers.append(travelImageVC)
                print(controllers.count)
            }
        }
        
        print("이건 될텐데")
        print(controllers.count)
//        self.pageViewControllerDelegate?.setUpPageController(numberOfPages: controllers.count)
        return controllers
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false

        delegate = self
        dataSource = self
        
        self.turnToPage(index: 0)
    }
    
    
    func turnToPage(index: Int) {
        let controller = controllers[index]
        var direction = UIPageViewControllerNavigationDirection.forward
        
        if let currentVC = viewControllers?.first {
            let currentIndex = controllers.index(of: currentVC)!
            if currentIndex > index {
                direction = .reverse
            }
        }
        
        self.configureDisplaying(viewController: controller)
        
        setViewControllers([controller], direction: direction, animated: true, completion: nil)
    }
    
    
    func configureDisplaying(viewController: UIViewController) {
        for (index, vc) in controllers.enumerated() {
            
            if viewController === vc {
                if let travelImageVC = viewController as? TravelImageViewController {
                   
                    guard let images = images else { return }
                    
                    Alamofire
                        .request(images[index].productImg)
                        .responseData { (response) in
                            
                            switch response.result {
                            case .success(let value):
                                
                                travelImageVC.image = UIImage(data: value)
                                
                            case .failure(let error):
                                print("\n---------- [ cityImage load fail ] -----------\n")
                                print(error.localizedDescription)
                            }
                    }
                    
                    self.pageViewControllerDelegate?.turnPageController(to: index)
                    
                    // viewController is indeed this vc : `===`
                    /***************************************************
                     << STUDY >>
                     < === (or !==) >
                     -. Checks if the values are identical (both point to the same memory address).
                     -. Comparing reference types.
                     -. Like == in Obj-C (pointer equality).
                     
                     < == (or !=) >
                     -. Checks if the values are the same.
                     -. Comparing value types.
                     -. Like isEqual: in Obj-C (However, you can override isEqual in Obj-C).
                     ***************************************************/
                }
            }
        }
    }
}


// MARK:  - UIPageViewController DataSource
extension TravelImagesPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // viewController : current
        // return VC : Before viewController
        
        if let index = controllers.index(of: viewController) {
            if index > 0 {
                return controllers[index-1]
            }
        }
        return controllers.last
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = controllers.index(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            }
        }
        return controllers.first
    }
}


extension TravelImagesPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.configureDisplaying(viewController: pendingViewControllers.first as! TravelImageViewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            self.configureDisplaying(viewController: previousViewControllers.first as! TravelImageViewController)
        }
    }
}
