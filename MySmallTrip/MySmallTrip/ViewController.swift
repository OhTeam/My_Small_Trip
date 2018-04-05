//
//  ViewController.swift
//  MySmallTrip
//
//  Created by KimYong Ho on 02/04/2018.
//  Copyright © 2018 OhTeam. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: YS
        tmpOpenLogInVC()  // to see log in view controller
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - YS
    // Open login view controller temporarily
    func tmpOpenLogInVC() {
        let tmpStoryboard = UIStoryboard(name: "LogIn", bundle: nil)
        let tmpLogInVC = tmpStoryboard.instantiateInitialViewController() as! LogInViewController
        self.present(tmpLogInVC, animated: true)
        
//        let tmpLogInVC = LogInViewController()
//        self.present(tmpLogInVC, animated: false, completion: nil)        
    }
}

