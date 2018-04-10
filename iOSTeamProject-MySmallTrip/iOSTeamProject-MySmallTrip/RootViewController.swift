//
//  RootViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 10..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit
import FBSDKCoreKit

class RootViewController: UIViewController {

    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    @IBOutlet private weak var facebookLoginButton: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLayout()
        facebookLoginButton.delegate = self
        
        if let token = FBSDKAccessToken.current() {
            fetchProfile()
        }
    }

    
    // Button CornerRadius & border 적용
    private func updateLayout() {
        loginButton.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
        
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = UIColor.Custom.mainColor.cgColor
    }
    
    private func fetchProfile() {
        print("fetch")
        
        let params = ["fields":"email, name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: params).start { (connection, result, error) in
        
            if error != nil {
                print(error)
                return
            }
            
            print(result)
            
        }
    }

}



extension RootViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("login")
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
    }
}
