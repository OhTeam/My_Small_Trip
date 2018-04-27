//
//  ViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 10..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // addButtonsToOpenViews() // For temporarily execution
        
        // seRootVCOpen()
        
        setScreen()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // for prevention of all white screen between LaunchScreen and Root view controller
    private func setScreen() {
        let screen: UIImageView = UIImageView(image: UIImage(named: "launchScreen"))
        screen.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(screen)
        
        screen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        screen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        screen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        screen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    // se
    func seRootVCOpen() {
        let btn = UIButton()
        btn.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        btn.backgroundColor = UIColor.Custom.mainColor
        btn.setTitle("test", for: .normal)
        btn.addTarget(self, action: #selector(btnTarget(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func btnTarget(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
        self.present(nextVC, animated: false, completion: nil)
    }
    
    // MARK: - YS Buttons to open view controllers
    func addButtonsToOpenViews() {
        // create temporary views
        let tmpView: UIView = UIView()
        let showLogIn: UIButton = UIButton()
        let showProfile: UIButton = UIButton()
        
        // set tmporary views
        // tmpView
        tmpView.translatesAutoresizingMaskIntoConstraints = false
        
        // login button
        showLogIn.setTitle("Log In", for: .normal)
        showLogIn.setTitleColor(.black, for: .normal)
        showLogIn.titleLabel?.textAlignment = .center
        showLogIn.layer.borderColor = UIColor.black.cgColor
        showLogIn.layer.borderWidth = 1
        showLogIn.addTarget(self, action: #selector(showLogIn(_:)), for: .touchUpInside)
        showLogIn.translatesAutoresizingMaskIntoConstraints = false
        
        // profile button
        showProfile.setTitle("Profile", for: .normal)
        showProfile.setTitleColor(.black, for: .normal)
        showProfile.titleLabel?.textAlignment = .center
        showProfile.layer.borderColor = UIColor.black.cgColor
        showProfile.layer.borderWidth = 1
        showProfile.addTarget(self, action: #selector(showProfile(_:)), for: .touchUpInside)
        showProfile.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tmpView)
        tmpView.addSubview(showLogIn)
        tmpView.addSubview(showProfile)
        
        // set auto layout
        // tmpView
        tmpView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        tmpView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        tmpView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        tmpView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        // login button
        showLogIn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        showLogIn.topAnchor.constraint(equalTo: tmpView.topAnchor).isActive = true
        showLogIn.leadingAnchor.constraint(equalTo: tmpView.leadingAnchor).isActive = true
        showLogIn.trailingAnchor.constraint(equalTo: tmpView.trailingAnchor).isActive = true
        
        // profile button
        showProfile.heightAnchor.constraint(equalToConstant: 30).isActive = true
        showProfile.bottomAnchor.constraint(equalTo: tmpView.bottomAnchor).isActive = true
        showProfile.leadingAnchor.constraint(equalTo: tmpView.leadingAnchor).isActive = true
        showProfile.trailingAnchor.constraint(equalTo: tmpView.trailingAnchor).isActive = true
    }
    
    
    // MARK: - YS @objc funcs to open view controllers
    @objc private func showLogIn(_ sender: UIButton) {
        let tmpStoryBoard = UIStoryboard(name: "Login", bundle: nil)
        let logInVC: LogInViewController = tmpStoryBoard.instantiateInitialViewController() as! LogInViewController
        self.present(logInVC, animated: true)
    }
    
    @objc private func showProfile(_ sender: UIButton) {
        let profileVC: ProfileViewController = ProfileViewController()
        let tmpNaviVC = UINavigationController(rootViewController: profileVC)
        tmpNaviVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        let tmpTabBarVC = UITabBarController()
        tmpTabBarVC.viewControllers = [tmpNaviVC]

/*
        // Navigation Bar setting
        // to make back button like '<' with red color
        tmpNaviVC.navigationBar.topItem?.title = ""
        tmpNaviVC.navigationBar.tintColor = .red
        
        // to set the title image of navigation controller as the default image
        tmpNaviVC.navigationBar.topItem?.titleView = naviView()
*/
        self.present(tmpTabBarVC, animated: true)
    }
    
    // Navigation Controller's title image
    private func naviView() -> UIView {
        let tmp: UIView = UIView()
        let tmpImageView: UIImageView = UIImageView(image: UIImage(named: "titleImage"))
        tmpImageView.translatesAutoresizingMaskIntoConstraints = false
        tmp.addSubview(tmpImageView)
        
        // This doesn't always need to be
        tmpImageView.topAnchor.constraint(equalTo: tmp.topAnchor).isActive = true
        tmpImageView.bottomAnchor.constraint(equalTo: tmp.bottomAnchor).isActive = true
        tmpImageView.leadingAnchor.constraint(equalTo: tmp.leadingAnchor).isActive = true
        tmpImageView.trailingAnchor.constraint(equalTo: tmp.trailingAnchor).isActive = true
        
        return tmp
    }
}
