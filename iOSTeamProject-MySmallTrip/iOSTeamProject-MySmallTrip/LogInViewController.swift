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
    private var logInFailureNoti: UILabel?
    private var emailTextField: TextFieldWithInsets?
    private var pwTextField: TextFieldWithInsets?
    private var logInButton: UIButton?
    private var lowerDesLabel: UILabel?
    
    // Preparation for user email transmission from SignUp view controller
    var loginEmail: String? {
        didSet {
            guard let emailTextField = emailTextField else { return }
            emailTextField.text = loginEmail
        }
    }
    
    private var safeGuide: UILayoutGuide?
    private var textFieldPositionConstraint: NSLayoutConstraint?
    private let movingHeight: CGFloat = 130 // distance to be moved at keyboard-up
    
    
    
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
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    deinit {
        print("LogIn VC is disposed")
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        guard let basicView = basicView,
            let logInFailureNoti = logInFailureNoti,
            let dismissImgBtnView = dismissImgBtnView,
            let titleLabel = self.titleLabel,
            let upperDesLabel = self.upperDesLabel,
            let emailTextField = self.emailTextField,
            let pwTextField = self.pwTextField,
            let logInButton = self.logInButton,
            let lowerDesLabel = self.lowerDesLabel
            else { return }
        
        self.view.addSubview(basicView)
        self.view.addSubview(logInFailureNoti)
        self.view.addSubview(dismissImgBtnView)  // MARK: subViews were already laid out inside
        basicView.addSubview(titleLabel)
        basicView.addSubview(upperDesLabel)
        basicView.addSubview(emailTextField)
        basicView.addSubview(pwTextField)
        basicView.addSubview(logInButton)
        basicView.addSubview(lowerDesLabel)
    }
    
    // MARK: - Create All Components
    /// Create all components on this view controller
    private func createItems() {
        setBasicView()
        setLogInFailureNoti()
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
    
    private func setLogInFailureNoti() {
        logInFailureNoti = UILabel()
        logInFailureNoti!.text = "이메일 혹은 비밀번호가 틀립니다. 다시 시도해 주세요."
        logInFailureNoti!.textColor = .white
        logInFailureNoti!.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        logInFailureNoti!.backgroundColor = .gray
        logInFailureNoti!.alpha = 0.5
        logInFailureNoti!.layer.cornerRadius = 10
        logInFailureNoti!.clipsToBounds = true
        logInFailureNoti!.textAlignment = .center
        logInFailureNoti!.isHidden = true
        logInFailureNoti!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDismissImgBtnView() {
        dismissImgBtnView = UIView()
        dismissImgBtnView!.translatesAutoresizingMaskIntoConstraints = false
        
        let dismissImageView = UIImageView(image: UIImage(named: "dismiss"))
        dismissImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let dismissButton = UIButton()
        dismissButton.backgroundColor = .clear
        dismissButton.addTarget(self, action: #selector(dismissLogInVC(_:)), for: .touchUpInside)
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
        emailTextField = TextFieldWithInsets()
        emailTextField!.delegate = self
        emailTextField!.tag = 1
        emailTextField!.placeholder = "Your Email"
        emailTextField!.keyboardType = .emailAddress
        emailTextField!.returnKeyType = .next
        emailTextField!.spellCheckingType = .no
        emailTextField!.autocorrectionType = .no
        emailTextField!.autocapitalizationType = .none
        emailTextField!.textAlignment = .left
        emailTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        emailTextField!.font = UIFont.systemFont(ofSize: 14)
        emailTextField!.textInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        emailTextField!.layer.borderWidth = 1
        emailTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        emailTextField!.layer.cornerRadius = 5
        emailTextField!.clipsToBounds = true
        emailTextField!.addTarget(self, action: #selector(moveUpAllComponents(_:)), for: UIControlEvents.touchDown)
        emailTextField!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setPWTextField() {
        pwTextField = TextFieldWithInsets()
        pwTextField!.isSecureTextEntry = true
        pwTextField!.delegate = self
        pwTextField!.tag = 2
        pwTextField!.placeholder = "Password"
        pwTextField!.returnKeyType = .join
        pwTextField!.textAlignment = .left
        pwTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        pwTextField!.font = UIFont.systemFont(ofSize: 14)
        pwTextField!.textInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        pwTextField!.layer.cornerRadius = 5
        pwTextField!.clipsToBounds = true
        pwTextField!.layer.borderWidth = 1
        pwTextField!.addTarget(self, action: #selector(moveUpAllComponents(_:)), for: .touchDown)
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
        logInButton!.addTarget(self, action: #selector(touchLogIn(_:)), for: .touchUpInside)
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
    
    // MARK: - Set Layout
    /// Set layout components
    private func setLayout() {
        guard let basicView = basicView,
            let logInFailureNoti = logInFailureNoti,
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
        
        // LogIn Failure Notification Label
        logInFailureNoti.heightAnchor.constraint(equalToConstant: 24).isActive = true
        logInFailureNoti.widthAnchor.constraint(equalToConstant: 312).isActive = true
        logInFailureNoti.centerXAnchor.constraint(equalTo: safeGuide!.centerXAnchor).isActive = true
        logInFailureNoti.topAnchor.constraint(equalTo: safeGuide!.topAnchor, constant: 156).isActive = true
        
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
    
    
    // MARK: - Notify wrong login information
    private func notifyWrongLogInInfo() {
        guard let emailTextField = emailTextField,
            let pwTextField = pwTextField,
            let logInFailureNoti = logInFailureNoti
            else { return }
        
        reInitializeTextFields()
        emailTextField.layer.borderColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1).cgColor
        pwTextField.layer.borderColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1).cgColor
        logInFailureNoti.isHidden = false
    }
    
    // MARK: - Re-initialize text on textfields
    private func reInitializeTextFields() {
        guard let emailTextField = emailTextField,
            let pwTextField = pwTextField
            else { return }
        
        emailTextField.text = nil
        pwTextField.text = nil
    }
    
    // MARK: - Log In
    private func logIn() {
        guard let textFieldPositionConstraint = textFieldPositionConstraint else { return }
        let logInLink: String = "https://myrealtrip.hongsj.kr/login/"
        let param: Dictionary<String, Any> = ["username":self.emailTextField?.text ?? "", "password":self.pwTextField?.text ?? ""]
        
        // temporary parameters for login process
        // let param: Parameters = ["username":"tmpUser@tmp.com", "password":"tmp12345"]
        
        importLibraries.connectionOfSeverForDataWith(logInLink, method: .post, parameters: param, headers: nil, success: { (data) in
            if let userLoggedIn = try? JSONDecoder().decode(EmailLogIn.self, from: data) {
                self.setUserData(userLoggedIn: userLoggedIn)
                print("login succeeded")
                
                // to see logged user data
                // self.printDataOf(user: UserData.user)
                
                // YS
                self.reInitializeTextFields()
                textFieldPositionConstraint.constant = 0
                let profileVC: ProfileViewController = ProfileViewController()
                let tmpNaviVC = UINavigationController(rootViewController: profileVC)
                tmpNaviVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
                let tmpTabBarVC = UITabBarController()
                tmpTabBarVC.viewControllers = [tmpNaviVC]
                self.present(tmpTabBarVC, animated: true)
                
                // dev
//                self.reInitializeTextFields()
//                let rootStoryboard = UIStoryboard(name: "Root", bundle: nil)
//                let mainTabBarVC = rootStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
//                self.present(mainTabBarVC, animated: true)
                
            }
        }) { (error) in
            self.notifyWrongLogInInfo()
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Set User Data after logging in
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
        
        importLibraries.connectionOfServerForJSONWith(wishListLink, method: .get, parameters: nil, headers: header, success: { (json) in
            if let datas = json as? [[String:Any]] {
                for data in datas {
                    let pkInt = data["pk"] as! Int
                    UserData.user.setWishListPrimaryKeys(wishListPrimaryKey: pkInt)
                }
            }
        }) { (error) in
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
    
    // MARK: - Targets
    @objc private func dismissLogInVC(_ sender: UIButton) {
        // to reduce time for keyboard to disappear
        if emailTextField?.isFirstResponder == true {
            emailTextField?.resignFirstResponder()
        } else if pwTextField?.isFirstResponder == true {
            pwTextField?.resignFirstResponder()
        }
        
        // YS
        self.dismiss(animated: true, completion: nil)
        
        // dev
//        if self.presentingViewController is SignUpViewController {
//            self.presentingViewController?.presentingViewController?.dismiss(animated: true)
//        } else {
//            self.presentingViewController?.dismiss(animated: true, completion: nil)
//        }
    }
    
    @objc private func touchLogIn(_ sender: UIButton) {
        guard let logInFailureNoti = logInFailureNoti else { return }
        logInFailureNoti.isHidden = true
        logIn()
    }
    
    @objc private func moveUpAllComponents(_ sender: UITextField) {
        guard let logInFailureNoti = logInFailureNoti,
            let textFieldPositionConstraint = textFieldPositionConstraint,
            let emailTextField = emailTextField,
            let pwTextField = pwTextField
            else { return }
        
        logInFailureNoti.isHidden = true
        sender.becomeFirstResponder() // for keyboard to start to be shown quickly
        textFieldPositionConstraint.constant = -(self.movingHeight) // due to current position is same
        emailTextField.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        pwTextField.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
    }
}

// MARK: - Extension of LogInVC
extension LogInViewController: UITextFieldDelegate {
    // when return key is tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let emailTextField = emailTextField,
            let pwTextField = pwTextField,
            let textFieldPositionConstraint = textFieldPositionConstraint
            else { return true }
        
        if textField.tag == 1 {
            emailTextField.resignFirstResponder()
            pwTextField.becomeFirstResponder()
        } else {
            pwTextField.resignFirstResponder()
            textFieldPositionConstraint.constant = 0
            logIn()
        }
        
        return true
    }
}
