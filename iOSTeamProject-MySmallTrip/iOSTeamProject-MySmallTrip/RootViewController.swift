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
        
        if FBSDKAccessToken.current() != nil {
//            print("\n---------- [ current access ] -----------\n")
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
        let url = UrlData.standards.basic + UrlData.standards.facebookLogin
        
        guard let token = FBSDKAccessToken.current().tokenString else { return }
        let params = ["access_token":token]
        
        Alamofire
            .request(url, method: .post, parameters: params)
            .responseJSON(completionHandler: { (response) in
                print(response.response!.statusCode)
                if response.response!.statusCode == 200 {
                    print("FB Login Success")
                    if let responseValue = response.result.value as! [String:Any]? {
//                        print(responseValue)
                    }
                } else {
                    print("FB Login Fail")
                    if let responseValue = response.result.value as! [String:Any]? {
                        print(responseValue)
                    }
                }
            })
        }

    }


extension RootViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        // 읽기 권한 불러오기. 이게 제대로 안되는 것 같은..느낌인데..t.t..
        // 읽기 권한 취소 / 거부하면 fail 되야함.
        loginButton.readPermissions = ["public_profile, email"]

        print("\n---------- [ login ] -----------\n")
        fetchProfile()
        
        // + 다른 아이디로 로그인하기가 있어야 할 것 같은데.......
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("\n---------- [ logout ] -----------\n")
    }
}
