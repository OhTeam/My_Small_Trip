//
//  SignUpViewController.swift
//  MySmallTrip
//
//  Created by KimYong Ho on 04/04/2018.
//  Copyright © 2018 OhTeam. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var singUpLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet weak var yourNameTextField: UITextField!
    @IBOutlet weak var yourEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    //회원가입 에러처리: response JSON으로 받아서 Alert 처리(msg는 Dic Value값)
    //User Info 서버로 전달, profile 사진은 url로 전달
    //비밀번호는 최소 8문자 이상 영문 + 숫자
    //키보드에 맞춰 올라가기 및 화면 아무데나 누르면(제스쳐) 키보드 사라지기 추가
    
    @IBAction func createAccountButton(_ sender: Any) {
        let urlString = "https://..........."
//        let parameter: Parameters = [
        
//        ]
        
    }
    
    
    //Profile 사진 이미지 피커로 구현하기: 사진 라이브러리 -> URL 경로 전달

    override func viewDidLoad() {
        super.viewDidLoad()
//        yourNameTextField.delegate = self
//        yourEmailTextField.delegate = self
//        passwordConfirmTextField.delegate = self
//        passwordTextField.delegate = self
//        phoneNumberTextField.delegate = self
        createUI()



    }
    
    private func createUI() {
        yourNameTextField.placeholder = "Your Name"
        yourEmailTextField.placeholder = "Your Email"
        passwordTextField.placeholder = "Password"
        passwordConfirmTextField.placeholder = "Password Confirm"
        phoneNumberTextField.placeholder = "Phone Number"
        
        //버튼 라운드 주기 아직 안함
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//extension ViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        if
//    }
//}
