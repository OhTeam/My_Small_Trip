//
//  LogInViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 10..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    private var basicView: UIView?
    private var dismissImgBtnView: UIView?
    private var titleLabel: UILabel?
    private var upperDesLabel: UILabel?
    private var emailTextField: UITextField?
    private var pwTextField: UITextField?
    private var logInButton: UIButton?
    private var lowerDesLabel: UILabel?
    
    private var safeGuide: UILayoutGuide?
    private var textFieldPositionConstraint: NSLayoutConstraint?
    private let movingHeight: CGFloat = 64 // distance to be moved at keyboard-up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        createItems() // create all components
        addSubviews() // add all components onto root view
        setLayout() // set auto layout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addSubviews() {
        guard let basicView = basicView,
            let dismissImgBtnView = dismissImgBtnView,
            let titleLabel = self.titleLabel,
            let upperDesLabel = self.upperDesLabel,
            let emailTextField = self.emailTextField,
            let pwTextField = self.pwTextField,
            let logInButton = self.logInButton,
            let lowerDesLabel = self.lowerDesLabel
            else { return }
        
        self.view.addSubview(basicView)
        self.view.addSubview(dismissImgBtnView)
        basicView.addSubview(titleLabel)
        basicView.addSubview(upperDesLabel)
        basicView.addSubview(emailTextField)
        basicView.addSubview(pwTextField)
        basicView.addSubview(logInButton)
        basicView.addSubview(lowerDesLabel)
    }
    
    private func createItems() {
        setBasicView()
        setDismissImgBtnView()
        setTitleLabel()
        setUpperDesLabel()
        setEmailTextField()
        setPWTextField()
        setLogInButton()
        setLowerDesLabel()
    }
    
    private func setBasicView() {
        basicView = UIView()
        basicView!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDismissImgBtnView() {
        dismissImgBtnView = UIView()
        dismissImgBtnView!.translatesAutoresizingMaskIntoConstraints = false
        
        let dismissImageView = UIImageView(image: UIImage(named: "logInDismiss"))
        dismissImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let dismissButton = UIButton()
        dismissButton.backgroundColor = .clear
        // TODO: ***** addTarget으로 dissmiss 구현
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        dismissImgBtnView!.addSubview(dismissImageView)
        dismissImgBtnView!.addSubview(dismissButton)
        
        // layout items on dismissImgBtnView
        // dismissImageView
        dismissImageView.topAnchor.constraint(equalTo: dismissImgBtnView!.topAnchor).isActive = true
        dismissImageView.bottomAnchor.constraint(equalTo: dismissImgBtnView!.bottomAnchor).isActive = true
        dismissImageView.leadingAnchor.constraint(equalTo: dismissImgBtnView!.leadingAnchor).isActive = true
        dismissImageView.trailingAnchor.constraint(equalTo: dismissImgBtnView!.trailingAnchor).isActive = true
        
        // dismissButton
        dismissButton.topAnchor.constraint(equalTo: dismissImgBtnView!.topAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: dismissImgBtnView!.bottomAnchor).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: dismissImgBtnView!.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: dismissImgBtnView!.trailingAnchor).isActive = true
        
        
    }
    
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel!.text = "LOG IN"
        titleLabel!.textAlignment = .center
        titleLabel!.textColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        titleLabel!.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        titleLabel!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpperDesLabel() {
        upperDesLabel = UILabel()
        upperDesLabel!.text = "Good to see you again"
        upperDesLabel!.textAlignment = .center
        upperDesLabel!.textColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        upperDesLabel!.font = UIFont.systemFont(ofSize: 14)
        upperDesLabel!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setEmailTextField() {
        emailTextField = UITextField()
        emailTextField!.delegate = self
        emailTextField!.tag = 1
        emailTextField!.placeholder = "Your Email"
        emailTextField!.textAlignment = .left
        emailTextField!.textColor = .black // temporary color value
        emailTextField!.font = UIFont.systemFont(ofSize: 14)
        emailTextField!.layer.borderWidth = 1
        emailTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        emailTextField!.layer.cornerRadius = 5
        emailTextField!.clipsToBounds = true // needs testing
        emailTextField!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setPWTextField() {
        pwTextField = UITextField()
        pwTextField!.delegate = self
        pwTextField!.tag = 2
        pwTextField!.placeholder = "Password"
        pwTextField!.textAlignment = .left
        pwTextField!.textColor = .black // temporary color value
        pwTextField!.font = UIFont.systemFont(ofSize: 14)
        pwTextField!.layer.cornerRadius = 5
        pwTextField!.clipsToBounds = true // needs testing
        pwTextField!.layer.borderWidth = 1
        pwTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        pwTextField!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLogInButton() {
        logInButton = UIButton()
        logInButton!.backgroundColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
        logInButton!.setTitle("LOG IN", for: .normal)
        logInButton!.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        logInButton!.setTitleColor(.white, for: .normal)
        logInButton!.layer.cornerRadius = 10
        logInButton!.clipsToBounds = true
        logInButton!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLowerDesLabel() {
        lowerDesLabel = UILabel()
        lowerDesLabel!.text = "Forgot your password?"
        lowerDesLabel!.textAlignment = .center
        lowerDesLabel!.textColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        lowerDesLabel!.font = UIFont.systemFont(ofSize: 14)
        lowerDesLabel!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setLayout() {
        guard let basicView = basicView,
            let dismissImgBtnView = dismissImgBtnView,
            let titleLabel = self.titleLabel,
            let upperDesLabel = self.upperDesLabel,
            let emailTextField = self.emailTextField,
            let pwTextField = self.pwTextField,
            let logInButton = self.logInButton,
            let lowerDesLabel = self.lowerDesLabel
            else { return }
        
        safeGuide = self.view.safeAreaLayoutGuide
        
        // Basic View
        basicView.heightAnchor.constraint(equalTo: safeGuide!.heightAnchor).isActive = true
        basicView.widthAnchor.constraint(equalTo: safeGuide!.widthAnchor).isActive = true
        textFieldPositionConstraint = basicView.centerYAnchor.constraint(equalTo: safeGuide!.centerYAnchor)
        textFieldPositionConstraint!.isActive = true
        basicView.centerXAnchor.constraint(equalTo: safeGuide!.centerXAnchor).isActive = true
        
        // Dismiss Image-Button View
        dismissImgBtnView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dismissImgBtnView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        dismissImgBtnView.topAnchor.constraint(equalTo: safeGuide!.topAnchor, constant: 16).isActive = true
        dismissImgBtnView.leadingAnchor.constraint(equalTo: safeGuide!.leadingAnchor, constant: 15).isActive = true
        
        // Title Label
        titleLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        titleLabel.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 80).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeGuide!.leadingAnchor, constant: 32).isActive = true
        basicView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 31).isActive = true
        
        // Uppder Description Label
        upperDesLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        upperDesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        upperDesLabel.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 32).isActive = true
        basicView.trailingAnchor.constraint(equalTo: upperDesLabel.trailingAnchor, constant: 31).isActive = true
        
        // Email TextField
        emailTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        pwTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 24).isActive = true
        basicView.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: 24).isActive = true
        
        // Password TextField
        pwTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        logInButton.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 24).isActive = true
        pwTextField.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 24).isActive = true
        basicView.trailingAnchor.constraint(equalTo: pwTextField.trailingAnchor, constant: 24).isActive = true
        
        // Log In Button
        logInButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        lowerDesLabel.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 24).isActive = true
        logInButton.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 24).isActive = true
        basicView.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor, constant: 24).isActive = true
        
        // Lower Description Label
        lowerDesLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        basicView.bottomAnchor.constraint(equalTo: lowerDesLabel.bottomAnchor, constant: 99).isActive = true
        lowerDesLabel.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 16).isActive = true
        basicView.trailingAnchor.constraint(equalTo: lowerDesLabel.trailingAnchor, constant: 15).isActive = true
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let emailTextField = emailTextField,
            let pwTextField = pwTextField,
            let textFieldPositionConstraint = textFieldPositionConstraint else { return true }
        if textField.tag == 1 {
            emailTextField.resignFirstResponder()
            // TODO: ***** 개선 필요 !!
            textFieldPositionConstraint.constant -= self.movingHeight  // view = safeGuideCenterY - movingHeight
            pwTextField.becomeFirstResponder()
        } else {
            textFieldPositionConstraint.constant = 0 // += self.movingHeight is possible to move over the safeGuide line
            pwTextField.resignFirstResponder()
        }
        
        return true
    }
}
