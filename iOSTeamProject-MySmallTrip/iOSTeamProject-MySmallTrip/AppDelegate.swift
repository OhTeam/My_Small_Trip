//
//  AppDelegate.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 10..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        self.emailTokenLogIn() //
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
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
                
                self.printDataOf(user: UserData.user)
            }
        }) { (error, code) in
            print(error.localizedDescription)
        }
    }
    
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
    
    // MARK: - Print User Data
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

