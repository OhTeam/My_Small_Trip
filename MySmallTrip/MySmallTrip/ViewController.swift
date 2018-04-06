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
        // login view test
//        let loginStoryboard = UIStoryboard(name: "LogIn", bundle: nil)
//        let logInVC = loginStoryboard.instantiateInitialViewController() as! LogInViewController
//        self.present(logInVC, animated: true)
        
        // profile view test
        let profileVC = ProfileViewController()
        self.present(profileVC, animated: false)
        
//        let tmpLogInVC = LogInViewController()
//        self.present(tmpLogInVC, animated: false, completion: nil)        
    }
}

