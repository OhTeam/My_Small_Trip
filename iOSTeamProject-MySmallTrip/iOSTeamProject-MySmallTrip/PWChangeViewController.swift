//
//  PWChangeViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 23..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class PWChangeViewController: UIViewController {
    
    private var firstPWLabel: UILabel?
    private var secondPWLabel: UILabel?
    private var firstPWTextField: TextFieldWithInsets?
    private var secondPWTextField: TextFieldWithInsets?
    private var pwDescription: UILabel?
    private var upperFailureNotiLabel: UILabel?
    private var lowerFailureNotiLabel: UILabel?
    
    private var notiString: String? {
        didSet {
            guard let upperFailureNotiLabel = upperFailureNotiLabel else { return }
            
            upperFailureNotiLabel.text = notiString
        }
    }
    
    private var movingHeightOfLowerFailureNotiLabel: NSLayoutConstraint?
    private let keyFrameHeight: CGFloat = 216

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        
        setNaviItem()
        setComponents()
        setLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Set Navigation Item
    private func setNaviItem() {
        self.navigationItem.title = "비밀번호 변경"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(goBack(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "등록", style: .plain, target: self, action: #selector(changePW(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    // MARK: - Set Components
    private func setComponents() {
        // First PW Label
        firstPWLabel = UILabel()
        firstPWLabel!.text = "새 비밀번호"
        firstPWLabel!.textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        firstPWLabel!.font = UIFont.systemFont(ofSize: 12)
        firstPWLabel!.textAlignment = .left
        firstPWLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(firstPWLabel!)
        
        // Second PW Label
        secondPWLabel = UILabel()
        secondPWLabel!.text = "새 비밀번호"
        secondPWLabel!.textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        secondPWLabel!.font = UIFont.systemFont(ofSize: 12)
        secondPWLabel!.textAlignment = .left
        secondPWLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(secondPWLabel!)
        
        // First Password
        firstPWTextField = TextFieldWithInsets()
        firstPWTextField!.textInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        firstPWTextField!.tag = 1
        firstPWTextField!.delegate = self
        firstPWTextField!.isSecureTextEntry = true
        firstPWTextField!.returnKeyType = .next
        firstPWTextField!.placeholder = "비밀번호 입력"
        firstPWTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        firstPWTextField!.font = UIFont.systemFont(ofSize: 16)
        firstPWTextField!.textAlignment = .left
        firstPWTextField!.layer.borderWidth = 1
        firstPWTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        firstPWTextField!.layer.cornerRadius = 5
        firstPWTextField!.clipsToBounds = true
        firstPWTextField!.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        firstPWTextField!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(firstPWTextField!)
        
        // Second Password
        secondPWTextField = TextFieldWithInsets()
        secondPWTextField!.textInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        secondPWTextField!.tag = 2
        secondPWTextField!.delegate = self
        secondPWTextField!.isSecureTextEntry = true
        secondPWTextField!.returnKeyType = .send
        secondPWTextField!.placeholder = "비밀번호 재입력"
        secondPWTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        secondPWTextField!.font = UIFont.systemFont(ofSize: 16)
        secondPWTextField!.textAlignment = .left
        secondPWTextField!.layer.borderWidth = 1
        secondPWTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        secondPWTextField!.layer.cornerRadius = 5
        secondPWTextField!.clipsToBounds = true
        secondPWTextField!.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        secondPWTextField!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(secondPWTextField!)
        
        // Password Description
        pwDescription = UILabel()
        pwDescription!.text = "영 대・소문자 및 숫자 그리고 특수문자를 포함한 8자의 비밀번호"
        pwDescription!.textColor = UIColor(displayP3Red: 74/255, green: 74/255, blue: 74/255, alpha: 0.5)
        pwDescription!.font = UIFont.systemFont(ofSize: 12)
        pwDescription!.textAlignment = .center
        pwDescription!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pwDescription!)
        
        // Upper Failure Notification
        upperFailureNotiLabel = UILabel()
        upperFailureNotiLabel!.backgroundColor = UIColor(displayP3Red: 74/255, green: 74/255, blue: 74/255, alpha: 0.8)
//        upperFailureNotiLabel!.text = "영문자가 포함된 8글자 이상의 비밀번호를 설정해 주세요."
        upperFailureNotiLabel!.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        upperFailureNotiLabel!.font = UIFont.systemFont(ofSize: 15)
        upperFailureNotiLabel!.textAlignment = .center
        upperFailureNotiLabel!.layer.cornerRadius = 5
        upperFailureNotiLabel!.clipsToBounds = true
        upperFailureNotiLabel!.isHidden = true
        upperFailureNotiLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(upperFailureNotiLabel!)
        
        // Lower Failure Notification
        lowerFailureNotiLabel = UILabel()
        lowerFailureNotiLabel!.backgroundColor = UIColor(displayP3Red: 74/255, green: 74/255, blue: 74/255, alpha: 0.8)
        lowerFailureNotiLabel!.text = "비밀번호를 정확히 입력해 주세요."
        lowerFailureNotiLabel!.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        lowerFailureNotiLabel!.font = UIFont.systemFont(ofSize: 15)
        lowerFailureNotiLabel!.textAlignment = .center
        lowerFailureNotiLabel!.layer.cornerRadius = 5
        lowerFailureNotiLabel!.clipsToBounds = true
        lowerFailureNotiLabel!.isHidden = true
        lowerFailureNotiLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(lowerFailureNotiLabel!)
    }
    
    private func setLayout() {
        guard let firstPWLabel = firstPWLabel,
            let secondPWLabel = secondPWLabel,
            let firstPWTextField = firstPWTextField,
            let secondPWTextField = secondPWTextField,
            let pwDescription = pwDescription,
            let upperFailureNotiLabel = upperFailureNotiLabel,
            let lowerFailureNotiLabel = lowerFailureNotiLabel
            else { return }
        
        let safeGuide = self.view.safeAreaLayoutGuide
        
        // First PW Label
        firstPWLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        firstPWLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 20).isActive = true
        firstPWLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        firstPWLabel.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -24).isActive = true
        
        // First PW TextField
        firstPWTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        firstPWTextField.topAnchor.constraint(equalTo: firstPWLabel.bottomAnchor, constant: 5).isActive = true
        firstPWTextField.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        firstPWTextField.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -24).isActive = true
        
        // Second PW Label
        secondPWLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        secondPWLabel.topAnchor.constraint(equalTo: firstPWTextField.bottomAnchor, constant: 20).isActive = true
        secondPWLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        secondPWLabel.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -24).isActive = true
        
        // Second PW TextField
        secondPWTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        secondPWTextField.topAnchor.constraint(equalTo: secondPWLabel.bottomAnchor, constant: 5).isActive = true
        secondPWTextField.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        secondPWTextField.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -24).isActive = true
        
        // Password Description
        pwDescription.heightAnchor.constraint(equalToConstant: 15).isActive = true
        pwDescription.topAnchor.constraint(equalTo: secondPWTextField.bottomAnchor, constant: 10).isActive = true
        pwDescription.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        pwDescription.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -24).isActive = true
        
        // Upper Failure Notification Label
        upperFailureNotiLabel.heightAnchor.constraint(equalToConstant: 29).isActive = true
        upperFailureNotiLabel.bottomAnchor.constraint(equalTo: lowerFailureNotiLabel.topAnchor, constant: -11).isActive = true
        upperFailureNotiLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 15).isActive = true
        upperFailureNotiLabel.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -15).isActive = true
        
        // Lower Failure Notification Label
        lowerFailureNotiLabel.heightAnchor.constraint(equalToConstant: 29).isActive = true
        movingHeightOfLowerFailureNotiLabel = lowerFailureNotiLabel.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -30)
        movingHeightOfLowerFailureNotiLabel!.isActive = true
        lowerFailureNotiLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 81).isActive = true
        lowerFailureNotiLabel.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -81).isActive = true
    }
    
    // MARK: - Pop Up Failure Notification Labels
    private func popUpFailureNotiLabels(_ isHidden: Bool) {
        guard let upperFailureNotiLabel = upperFailureNotiLabel,
            let lowerFailureNotiLabel = lowerFailureNotiLabel
            else { return }
        
        upperFailureNotiLabel.isHidden = isHidden
        lowerFailureNotiLabel.isHidden = isHidden
    }
    
    // MARK: - Verify Password
    private func verifyPW() -> Bool {
        guard let firstPWTextField = firstPWTextField,
            let secondPWTextFiedld = secondPWTextField
            else { return false }
      
        var isVerified: Bool = false
        let password = Password(firstPW: firstPWTextField.text!, secondPW: secondPWTextFiedld.text!)
        
        // first condition
        if firstPWTextField.text! == "" || password.isBlank {
            notiString = "아무것도 입력되지 않았거나 모두 빈칸입니다"
            popUpFailureNotiLabels(false)
            
        } else if !password.isSameAsSecondPW {
            notiString = "변경을 원하는 비밀번호와 재입력된 비밀번호가 다릅니다."
            popUpFailureNotiLabels(false)
            
        } else if !password.isOverEightCharacters {
            notiString = "비밀번호는 여덟글자 이상 작성되어야 합니다."
            popUpFailureNotiLabels(false)
            
        } else if password.hasBlank {
            notiString = "비밀번호에 빈칸은 포함되지 않습니다."
            popUpFailureNotiLabels(false)
            
        } else if password.hasOnlyNumber {
            notiString = "비밀번호는 숫자로만 구성되지 않습니다."
            popUpFailureNotiLabels(false)
            
        } else if !password.hasUppercase {
            notiString = "비밀번호에 영 대문자가 포함되지 않았습니다."
            popUpFailureNotiLabels(false)
            
        } else if !password.hasLowercase {
            notiString = "비밀번호에 영 소문자가 포함되지 않았습니다."
            popUpFailureNotiLabels(false)
            
        } else if !password.hasSpecialCharacter {
            notiString = "비밀번호에 특수문자가 포함되지 않았습니다."
            popUpFailureNotiLabels(false)
            
        } else if !password.hasNumber {
            notiString = "비밀번호에 숫자가 포함되지 않았습니다."
            popUpFailureNotiLabels(false)
            
        } else {
            isVerified = true
            popUpFailureNotiLabels(true)
        }
        
        return isVerified
    }
    
    // MARK: - Change Password
    private func changePW() {
        guard verifyPW(),
            let firstPWTextField = firstPWTextField,
            let secondPWTextField = secondPWTextField,
            let lowerFailureNotiLabel = lowerFailureNotiLabel,
            let movingHeightOfLowerFailureNotiLabel = movingHeightOfLowerFailureNotiLabel
            else { return }
        
        let pwChangeLink: String = "https://myrealtrip.hongsj.kr/members/info/password/"
        let header: Dictionary<String, String> = ["Authorization":"Token " + (UserData.user.token ?? "")]
        let param: Dictionary<String, Any> = ["password":firstPWTextField.text!, "password2":secondPWTextField.text!]
        
        importLibraries.connectionOfSeverForDataWith(pwChangeLink, method: .patch, parameters: param, headers: header, success: { (data, code) in
            firstPWTextField.text = ""
            secondPWTextField.text = ""
            movingHeightOfLowerFailureNotiLabel.constant = -24
            
            let notiMsg = """
비밀번호가
성공적으로 변경되었습니다.
"""
            
            let successAlert = UIAlertController(title: nil, message: notiMsg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
            }
            successAlert.addAction(okAction)
            self.present(successAlert, animated: false)
            
            print("Password changed")
            print(data)
            
        }) { (error, code) in
            // token 유효성 잃었을 때 처리 방안
            self.notiString = "네트워크 오류입니다. 다시 시행해 주세요."
            lowerFailureNotiLabel.isHidden = true
            
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Targets
    @objc private func goBack(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func changePW(_ sender: UIBarButtonItem) {
        changePW()
    }
    // MARK: Move Buttons Up
    @objc private func touchDown(_ sender: UITextField) {
        guard let movingHeightOfLowerFailureNotiLabel = movingHeightOfLowerFailureNotiLabel
            else { return }
        
        // Button Animation
        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
            movingHeightOfLowerFailureNotiLabel.constant = -24 - self.keyFrameHeight
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension PWChangeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let firstPWTextField = firstPWTextField,
            let secondPWTextField = secondPWTextField,
            let movingHeightOfLowerFailureNotiLabel = movingHeightOfLowerFailureNotiLabel
            else { return true }
        if textField.tag == 1 {
            firstPWTextField.resignFirstResponder()
            secondPWTextField.becomeFirstResponder()
        } else {
            secondPWTextField.resignFirstResponder()
            
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                movingHeightOfLowerFailureNotiLabel.constant = -24
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            changePW()
        }
        return true
    }
}
