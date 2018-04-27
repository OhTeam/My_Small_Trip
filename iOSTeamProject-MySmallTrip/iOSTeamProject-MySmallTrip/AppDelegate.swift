//
//  AppDelegate.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 10..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        if FBSDKAccessToken.current() != nil {
            // If being still logged in with Facebook
            facebookLogIn()
            
        } else if let dic = UserDefaults.standard.object(forKey: "emailUser") as? Dictionary<String, String>,
            let token = dic["token"], token != "" {
            // If being still logged in with Email
            emailTokenLogIn()
            
        } else {
            // init VC - rootVC
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyBoard = UIStoryboard(name: "Root", bundle: nil)
            let initialVC = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
            
            self.window?.rootViewController = initialVC
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    // MARK: - Email LogIn
    private func emailTokenLogIn() {
        guard let dic = UserDefaults.standard.object(forKey: "emailUser") as? Dictionary<String, String>,
            let token = dic["token"], token != ""
            else { return }
        
        let logInLink: String = "https://myrealtrip.hongsj.kr/members/info/"
        let header: Dictionary<String, String> = ["Authorization":"Token " + token]
        
        importLibraries.connectionOfSeverForDataWith(logInLink, method: .get, parameters: nil, headers: header, success: { (data, code) in
            if let userLoggedIn = try? JSONDecoder().decode(User.self, from: data) {
                UserData.user.setToken(token: token)
                self.setUserData(userLoggedIn: userLoggedIn)
                print("login succeeded in AppDelegate")
                
                // init VC - rootVC
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let storyBoard = UIStoryboard(name: "Root", bundle: nil)
                let initialVC = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
                
                self.window?.rootViewController = initialVC
                self.window?.makeKeyAndVisible()
                
            }
        }) { (error, code) in
            print(error.localizedDescription)
            
            UserData.user.isLoggedIn = false
            
            var tokenAlertVC = UIAlertController(title: "네트워크 오류", message: "네트워크 확인이 필요합니다.", preferredStyle: .alert)
            
            // to catch session expired
            if let code = code {
                switch code {
                case 400..<500:
                    tokenAlertVC = UIAlertController(title: "사용자 인증 완료", message: "사용자 인증이 만료되었습니다.", preferredStyle: .alert)
                default:
                    print(code)
                }
            }
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            tokenAlertVC.addAction(okAction)
            
            // init VC - rootVC
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyBoard = UIStoryboard(name: "Root", bundle: nil)
            let initialVC = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
            
            self.window?.rootViewController = initialVC
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController?.present(tokenAlertVC, animated: true)
        }
    }
    
    // MARK: Facebook LogIn
    private func facebookLogIn() {
        let url = UrlData.standards.basic + UrlData.standards.facebookLogin
        
        guard let token = FBSDKAccessToken.current().tokenString else { return }
        let params = ["access_token":token]
        
        importLibraries.connectionOfSeverForDataWith(url, method: .post, parameters: params, headers: nil, success: { (data, code) in
            do {
                let userData = try JSONDecoder().decode(EmailLogIn.self, from: data)
                self.setUserData(userLoggedIn: userData)
                
                // init VC - rootVC
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let storyBoard = UIStoryboard(name: "Root", bundle: nil)
                let initialVC = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
                
                self.window?.rootViewController = initialVC
                self.window?.makeKeyAndVisible()
                
            } catch(let error) {
                print("\n---------- [ JSON Decoder error ] -----------\n")
                print(error)
            }
        }) { (error, code) in
            print("\n---------- [ Alamofire request error ] -----------\n")
            print(error.localizedDescription)
        }
    }
    
    // MARK: Set UserData in Logging In - Eamil
    private func setUserData(userLoggedIn: User) {
        UserData.user.isLoggedIn = true
        UserData.user.setPrimaryKey(primaryKey: userLoggedIn.primaryKey)
        UserData.user.setUserName(userName: userLoggedIn.userName)
        UserData.user.setEmail(email: userLoggedIn.email)
        UserData.user.setFirstName(firstName: userLoggedIn.firstName)
        UserData.user.setPhoneNumber(phoneNumber: userLoggedIn.phoneNumber)
        UserData.user.setImgProfile(imgProfile: userLoggedIn.imgProfile)
        UserData.user.setIsFacebookUser(isFacebookUser: userLoggedIn.isFacebookUser)
        
        // Load Wish List
        self.loadWishList()
    }
    
    // MARK: Set UserData in Logging In - Facebook
    private func setUserData(userLoggedIn: EmailLogIn) {
        UserData.user.isLoggedIn = true
        UserData.user.setToken(token: userLoggedIn.token)
        UserData.user.setPrimaryKey(primaryKey: userLoggedIn.user.primaryKey)
        UserData.user.setUserName(userName: userLoggedIn.user.userName)
        UserData.user.setEmail(email: userLoggedIn.user.email)
        UserData.user.setFirstName(firstName: userLoggedIn.user.firstName)
        UserData.user.setPhoneNumber(phoneNumber: userLoggedIn.user.phoneNumber)
        UserData.user.setImgProfile(imgProfile: userLoggedIn.user.imgProfile)
        UserData.user.setIsFacebookUser(isFacebookUser: userLoggedIn.user.isFacebookUser)
        
        // Load Wish List
        self.loadWishList()
    }
    
    // MARK: - Load Wish List Primary Keys
    private func loadWishList() {
        guard let token = UserData.user.token else { return }
        let header: Dictionary<String, String> = ["Authorization": "Token " + token]
        let wishListLink: String = "http://myrealtrip.hongsj.kr/reservation/wishlist/"
        
        importLibraries.connectionOfServerForJSONWith(wishListLink, method: .get, parameters: nil, headers: header, success: { (json, code) in
            if let datas = json as? [[String:Any]] {
                for data in datas {
                    let pkInt = data["pk"] as! Int
                    UserData.user.setWishListPrimaryKeys(wishListPrimaryKey: pkInt)
                }
            }
        }) { (error, code) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Print User Data - temporary code
    func printDataOf(user: UserData) {
        print("token: " + (user.token ?? "nil"))
        if let primaryKey = user.primaryKey {
            print("primaryKey: \(primaryKey)")
        } else {
            print("primaryKey: nil")
        }
        print("userName: " + (user.userName ?? "nil"))
        print("email: " + (user.email ?? "nil"))
        print("firstName: " + (user.firstName ?? "nil"))
        print("phoneNumber: " + (user.phoneNumber ?? "nil"))
        print("imgProfile: " + (user.imgProfile ?? "nil"))
        if let isFacebookUser = user.isFacebookUser {
            print("isFacebookUser: \(isFacebookUser)")
        } else {
            print("isFacebookUser: nil")
        }
        if let _ = user.profileImgData {
            print("Data: OK")
        } else {
            print("Data: nil")
        }
        print("whishList: \(user.wishListPrimaryKeys)")
    }
}

