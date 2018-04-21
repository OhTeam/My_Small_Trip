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
                if response.response!.statusCode == 200 {
                    if let responseValue = response.result.value as! [String:Any]? {
                        
                        // 로그인 성공하면 fbuser singleton에 토큰값 / user name 저장
                        FBUser.standards.token = responseValue["token"] as? String
                        
                        guard let user = responseValue["user"] as! [String:Any]? else { return }
                        FBUser.standards.userName = user["first_name"] as? String
                        
                        self.fetchWishList()
                        self.moveToMainVC()
                    }

                } else {
                    print("FB Login Fail")
                    if let responseValue = response.result.value as! [String:Any]? {
                        print(responseValue)
                    }
                }
            })
        }
    
    
    func moveToMainVC() {
        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        self.present(mainVC, animated: true, completion: nil)
    }

    
    // MARK:  - WishList data get & User singleton save
    func fetchWishList() {
        
        guard let token = FBUser.standards.token else { return }
        let header = ["Authorization": "Token \(token)"]
        let url = UrlData.standards.basic + UrlData.standards.wishList
        
        Alamofire
            .request(url, method: .get, headers: header)
            .responseJSON { (response) in
                if let datas = response.result.value as! [[String:Any]]? {
                    for data in datas {
                        let pkInt = data["pk"] as! Int
                        FBUser.standards.pkList.append(pkInt)
                    }
                }
        }
    }
}


// MARK:  - FBSDK LoginButton Delegate
extension RootViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        if result.isCancelled {
            print("login cancle: \(result.isCancelled)")
        } else {
            loginButton.readPermissions = ["public_profile, email"]
            fetchProfile()
            moveToMainVC()
        }
        
        // 읽기 권한 불러오기. 이게 제대로 안되는 것 같은..느낌인데..t.t..
        // 읽기 권한 취소 / 거부하면 fail 되야함.
        
        // + 다른 아이디로 로그인하기가 있어야 할 것 같은데.......
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("\n---------- [ logout ] -----------\n")
        
        // fbuser singleton value값 삭제
        FBUser.standards.token = nil
        FBUser.standards.userName = nil
    }
}
