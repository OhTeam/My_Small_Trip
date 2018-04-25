//
//  ContactChangeViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 16..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class ContactChangeViewController: UIViewController {
    
    private var upperDesLabel: UILabel?
    private var tfDesLabel: UILabel?
    private var inputTextField: TextFieldWithInsets?
    private var getAuthButton: UIButton?
    
    private var movingHeightOfBtn: NSLayoutConstraint?
    private let keyFrameHeight: CGFloat = 216
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setNaviItem()
        setComponents()
        setLayout()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("ContactChange VC is disposed")
    }
    
    // MARK: - Set Nvaigation Item
    private func setNaviItem() {
        self.navigationItem.title = "연락처 변경"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "clearDismiss"), style: .done, target: self, action: #selector(popThis(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem?.tintColor = UIColor(displayP3Red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
    }
    
    // MARK: - Set Components
    private func setComponents() {
        // Upper Description Label
        upperDesLabel = UILabel()
        upperDesLabel!.text = "새 휴대폰 번호를 입력하고 인증해주세요."
        upperDesLabel!.font = UIFont.systemFont(ofSize: 14)
        upperDesLabel!.textAlignment = .left
        upperDesLabel!.textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        upperDesLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(upperDesLabel!)
        
        // TextField Description Label
        tfDesLabel = UILabel()
        tfDesLabel!.text = "휴대폰 번호"
        tfDesLabel!.font = UIFont.systemFont(ofSize: 12)
        tfDesLabel!.textAlignment = .left
        tfDesLabel!.textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        tfDesLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tfDesLabel!)
        
        // Input TextField
        inputTextField = TextFieldWithInsets()
        inputTextField!.delegate = self
        inputTextField!.placeholder = "전화번호를 입력하세요."
        inputTextField!.keyboardType = .numberPad
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(touchDone(_:)))
        let inputAccessoryView = UIToolbar()
        inputAccessoryView.items = [flexibleSpace, doneButton]
        inputAccessoryView.sizeToFit()
        inputTextField?.inputAccessoryView = inputAccessoryView
        
        inputTextField!.font = UIFont.systemFont(ofSize: 16)
        inputTextField!.textAlignment = .left
        inputTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        inputTextField!.textInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        inputTextField!.layer.borderWidth = 1
        inputTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        inputTextField!.layer.cornerRadius = 5
        inputTextField!.clipsToBounds = true
        inputTextField!.addTarget(self, action: #selector(moveBtnUp(_:)), for: .touchDown)
        inputTextField!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(inputTextField!)
        
        // Action Button
        getAuthButton = UIButton()
        getAuthButton!.setTitle("문자로 인증코드 보내기", for: .normal)
        getAuthButton!.setTitleColor(UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        getAuthButton!.titleLabel!.font = UIFont.systemFont(ofSize: 16)
        getAuthButton!.titleLabel!.textAlignment = .center
        getAuthButton!.backgroundColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
        getAuthButton!.layer.cornerRadius = 10
        getAuthButton!.clipsToBounds = true
        getAuthButton!.addTarget(self, action: #selector(getAuthCode(_:)), for: .touchUpInside)
        getAuthButton!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(getAuthButton!)
    }
    
    // MARK: - Set Layout of All Components
    private func setLayout() {
        guard let upperDesLabel = upperDesLabel,
            let tfDesLabel = tfDesLabel,
            let inputTextField = inputTextField,
            let getAuthButton = getAuthButton
            else { return }
        
        let safeGuide = self.view.safeAreaLayoutGuide
        
        // Upper Description Label
        upperDesLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 20).isActive = true
        tfDesLabel.topAnchor.constraint(equalTo: upperDesLabel.bottomAnchor, constant: 34).isActive = true
        upperDesLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 16).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: upperDesLabel.trailingAnchor, constant: 16).isActive = true
        
        // TextField Description Label
        inputTextField.topAnchor.constraint(equalTo: tfDesLabel.bottomAnchor, constant: 5).isActive = true
        tfDesLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: tfDesLabel.trailingAnchor, constant: 24).isActive = true
        
        // Input TextField
        inputTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: 24).isActive = true
        
        // Action Button
        getAuthButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        getAuthButton.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: getAuthButton.trailingAnchor, constant: 24).isActive = true
        movingHeightOfBtn = safeGuide.bottomAnchor.constraint(equalTo: getAuthButton.bottomAnchor, constant: 24)
        movingHeightOfBtn!.isActive = true
    }
    
    // MARK: - Requset Authentication Number
    private func requestAuthNumber() {
        guard let inputTextField = inputTextField,
            let movingHeightOfBtn = movingHeightOfBtn
            else { return }
        
        let requestAuthNumLink = "https://myrealtrip.hongsj.kr/members/info/phone-change/"
        let header: Dictionary<String, String> = ["Authorization":"Token " + (UserData.user.token ?? "")]
        let param: Dictionary<String, Any> = ["phone_number":inputTextField.text!]
        
        importLibraries.connectionOfSeverForDataWith(requestAuthNumLink, method: .post, parameters: param, headers: header, success: { (data, code) in
            
            inputTextField.resignFirstResponder()
            
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                movingHeightOfBtn.constant = 24
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            let notiMsg: String = """
입력하신 번호로 인증코드가 발송되었습니다.
3분 내에 인증코드를 입력해 주세요.
"""
            let authNumNotiAlert = UIAlertController(title: inputTextField.text, message: notiMsg, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                let smsAuthVC = SMSAuthenticationViewController()
                smsAuthVC.setPhoneNumberForAuth(phoneNumber: inputTextField.text)
                self.navigationController?.pushViewController(smsAuthVC, animated: false)
                inputTextField.text = ""
            }
            authNumNotiAlert.addAction(cancelAction)
            authNumNotiAlert.addAction(okAction)
            self.present(authNumNotiAlert, animated: false)
            
            print("Authentication sent")
            print("data")
            
        }) { (error, code) in
            // 토큰 유효하지 않을 때 처리 방안
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Targets
    @objc private func popThis(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func moveBtnUp(_ sender: UITextField) {
        guard let movingHeightOfBtn = movingHeightOfBtn,
            let inputTextField = inputTextField
            else { return }
        
        inputTextField.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        
        // Button Animation
        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
            // height should be changed with the real one
            movingHeightOfBtn.constant = 24 + self.keyFrameHeight
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func getAuthCode(_ sender: UIButton) {
        guard let inputTextField = inputTextField else {
            return
        }
        
        if inputTextField.text == "" {
            inputTextField.layer.borderColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1).cgColor
            return
        }
        
        requestAuthNumber()
        
        // -> tmp
//        self.inputTextField!.resignFirstResponder()
//        self.movingHeightOfBtn!.constant = 24
//
//        let notiMsg: String = """
//입력하신 번호로 인증코드가 발송되었습니다.
//3분 내에 인증코드를 입력해 주세요.
//"""
//
//        let authNumNotiAlert = UIAlertController(title: inputTextField!.text, message: notiMsg, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
//            let smsAuthVC = SMSAuthenticationViewController()
//            smsAuthVC.setPhoneNumberForAuth(phoneNumber: self.inputTextField!.text)
//            self.navigationController?.pushViewController(smsAuthVC, animated: false)
//            self.inputTextField!.text = ""
//        }
//        authNumNotiAlert.addAction(cancelAction)
//        authNumNotiAlert.addAction(okAction)
//        self.present(authNumNotiAlert, animated: false)
        
    }
    
    @objc private func touchDone(_ sender: UIBarButtonItem) {
        guard let movingHeightOfBtn = movingHeightOfBtn,
            let inputTextField = inputTextField
            else { return }        
        inputTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            movingHeightOfBtn.constant = 24
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension ContactChangeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let movingHeightOfBtn = movingHeightOfBtn,
        let inputTextField = inputTextField
        else { return true }
        
        textField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            movingHeightOfBtn.constant = 24
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        if inputTextField.text == "" {
            inputTextField.layer.borderColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1).cgColor
            return true
        }
        
        requestAuthNumber()
        
        return true
    }
}
