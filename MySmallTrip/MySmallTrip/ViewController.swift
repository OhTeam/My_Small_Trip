//
//  ViewController.swift
//  MySmallTrip
//
//  Created by KimYong Ho on 02/04/2018.
//  Copyright © 2018 OhTeam. All rights reserved.
//

import UIKit
import Alamofire

import FBSDKLoginKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    @IBOutlet private weak var facebookLoginButton: FBSDKLoginButton!
    
    @IBOutlet private weak var testBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLayout()
//        facebookLoginButton.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
//        testBtn.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
    }
    
    
    // Button CornerRadius & border 적용
    private func updateLayout() {
        loginButton.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
        
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = UIColor.Custom.mainColor.cgColor
    }
    
    
    // 페이스북 로그인 버튼 클릭
    // 버튼 눌렀을 때 알럿 사라짐..
//    @objc func loginAction(_ sender: FBSDKLoginButton) {
//
//        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
//
//            if (error == nil){
//                let fbloginresult : FBSDKLoginManagerLoginResult = result!
//
//                if fbloginresult.grantedPermissions != nil {
//
//                    print("\n---------- [ fbloginresult.grantedPermissions ] -----------\n")
//                    print(fbloginresult.grantedPermissions)
//
//                    if(fbloginresult.grantedPermissions.contains("email"))
//                    {
//                        self.getFBUserData()
//                        fbLoginManager.logOut()
//                    }
//                }
//            }
//        }
//    }
    
    // 유저 데이터 가져오기
    private func getFBUserData() {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print("\n---------- [ result ] -----------\n")
                    // JSON Type
                    print(result!)
                }
            })
        }
    }
    
}


//extension ViewController: FBSDKLoginButtonDelegate {
//
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//        <#code#>
//    }
//
//
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        <#code#>
//    }
//}




