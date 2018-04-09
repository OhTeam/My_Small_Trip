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
        tmpOpenVCs()  // to see log in view controller
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - YS
    // Open login view controller temporarily
    func tmpOpenVCs() {
        
        // make buttons temporarily
        let showLoginView = UIButton()
        let showProfileView = UIButton()
        
        showLoginView.setTitle("LogIn View", for: .normal)
        showProfileView.setTitle("Profile View", for: .normal)
        
        showLoginView.setTitleColor(.black, for: .normal)
        showProfileView.setTitleColor(.black, for: .normal)
        
        showLoginView.layer.borderColor = UIColor.black.cgColor
        showProfileView.layer.borderColor = UIColor.black.cgColor
        
        showLoginView.layer.borderWidth = 1
        showProfileView.layer.borderWidth = 1
        
        showLoginView.addTarget(self, action: #selector(showLogInView(_:)), for: .touchUpInside)
        showProfileView.addTarget(self, action: #selector(showProfileView(_:)), for: .touchUpInside)
        
        showLoginView.translatesAutoresizingMaskIntoConstraints = false
        showProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(showLoginView)
        self.view.addSubview(showProfileView)
        
        // login view layout
        showLoginView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        showLoginView.heightAnchor.constraint(equalTo: showLoginView.widthAnchor, multiplier: 0.3).isActive = true
        showLoginView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        showLoginView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        showProfileView.topAnchor.constraint(equalTo: showLoginView.topAnchor, constant: 100).isActive = true
        
        // profile view layout
        showProfileView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        showProfileView.widthAnchor.constraint(equalTo: showProfileView.heightAnchor, multiplier: 3).isActive = true
        showProfileView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func showLogInView(_ sender: UIButton) {
        let logInVC = LogInViewController()
        self.present(logInVC, animated: false)
    }
    
    @objc func showProfileView(_ sender: UIButton) {
        let profileVC = ProfileViewController()
        self.present(profileVC, animated: false)
    }
}

