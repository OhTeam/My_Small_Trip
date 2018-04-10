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
        
        // MARK: YS code ->
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
        // MARK: <- YS code
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: YS @objc funcs ->
    @objc func showLogIn(_ sender: UIButton) {
        let tmpStoryBoard = UIStoryboard(name: "Login", bundle: nil)
        let logInVC: LogInViewController = tmpStoryBoard.instantiateInitialViewController() as! LogInViewController
        self.present(logInVC, animated: true)
    }
    
    @objc func showProfile(_ sender: UIButton) {
        let profileVC: ProfileViewController = ProfileViewController()
        self.present(profileVC, animated: true)
    }
    // MARK: <- YS @objc funcs
}

