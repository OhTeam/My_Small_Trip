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
            print(token)
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
        
        let fbParams = ["fields":"email, name, picture.type(large), phone"]
        FBSDKGraphRequest(graphPath: "me", parameters: fbParams).start { (connection, result, error) in
        
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let result = result as? NSDictionary,
            let email = result["email"] as? String,
            let name = result["name"] as? String,
            let pic
                else { return }
            
            
        }
            
//            let userParams = [
//                "username":
//                "email": email,
//                "first_name":
//                "phone_number":
//                "img_profile":
//                "is_facebook_user":
//            ]
//
//            let postParams = [
//                "token": FBSDKAccessToken.current(),
//                "user": userParams
//                ]
            
        
            
            
//            {
//                "token": "토큰값"
//                "user": {
//                    "pk": "사용자 id",
//                    "username": "사용자 이메일",
//                    "email": "사용자 이메일",
//                    "first_name": "사용자 이름",
//                    "phone_number": "사용자 핸드폰 번호",
//                    "img_profile": "프로필 이미지",
//                    "is_facebook_user": "페이스북 유저(True)"
//                }
//            }
//
//            let url = "http://myrealtrip.hongsj.kr/" + "/sign-up/"
//            Alamofire
//                .request(url, method: .post, parameters: postParams)
//                .responseJSON { (response) in
//                    print(response.response?.statusCode)
//
//                    if let responseValue = response.result.value as! [String:Any]? {
//                        print(responseValue.keys)
//                        print(responseValue.values)
//                    }
//            }
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
