//
//  SignUpViewController.swift
//  MySmallTrip
//
//  Created by KimYong Ho on 04/04/2018.
//  Copyright © 2018 OhTeam. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("http://myrealtrip.hongsj.kr")
        .validate()
            .responseJSON { (response) in
                print(response.response?.statusCode)
                if let responseValue = response.result.value as! [String: Any]? {
                    print(responseValue.keys)
                    print(responseValue.values)
                }
        }
        
        //MARK: - 바탕 터치시, 키보드 사라지기
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        contentView.addGestureRecognizer(tap)
        
        
        yourNameTextField.delegate = self
        yourEmailTextField.delegate = self
        passwordConfirmTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        createUI()
        setupProfileImage()
    }
    

    //MARK: - Head label
    @IBOutlet weak var singUpLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    
    //MARK: - Profile image 입력부
    //Profile 사진 이미지 피커로 구현하기: 사진 라이브러리 -> URL 경로 전달 (구현 못함)
    @IBOutlet weak var profileImage: UIImageView!
    let imagePicker = UIImagePickerController()
    
    @IBAction func profileImageButton(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: "프로필사진", message: "원하는 사진을 넣어 주세요", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
        }
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    func openLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: false, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: false, completion: nil)
        } else {
            print("Camera is not available.")
        }
    }
    
    
    //MARK: - TextField 및 View
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var yourNameTextField: UITextField!
    @IBOutlet weak var yourEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - 가입 버튼 및 action
    @IBOutlet weak var createAccountButton: UIButton!
    //회원가입 에러처리: response JSON으로 받아서 Alert 처리(msg는 Dic Value값)
    //User Info 서버로 전달, profile 사진은 url로 전달
    //비밀번호는 최소 8문자 이상 영문 + 숫자
    //키보드에 맞춰 올라가기 및 화면 아무데나 누르면(제스쳐) 키보드 사라지기 추가
    
    @IBAction func createAccountButton(_ sender: Any) {
        let urlString = "http://myrealtrip.hongsj.kr/sign-up/"
        let parameter: Parameters = [
            "email" : yourEmailTextField.text!,
            "first_name" : yourNameTextField.text!,
            "password" : passwordTextField.text!,
            "password2" : passwordConfirmTextField.text!,
            "phone_number" : phoneNumberTextField.text!,
            "img_profile" : ""
        ]
        
        Alamofire
        .request(urlString, method: .post, parameters: parameter)
            .responseJSON { (response) in
                print(response.response?.statusCode)
                if let responseValue = response.result.value as! [String: Any]? {
                    print(responseValue.keys)
                    print(responseValue.values)
                }
        }
    }
    
    //MARK: - UI 구현부
    private func createUI() {
        yourNameTextField.placeholder = "Your Name"
        yourEmailTextField.placeholder = "Your Email"
        passwordTextField.placeholder = "Password"
        passwordConfirmTextField.placeholder = "Password Confirm"
        phoneNumberTextField.placeholder = "Phone Number"
        createAccountButton.layer.cornerRadius = 5
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - TextReturn 구현부
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if self.yourEmailTextField.isFirstResponder {
            yourNameTextField.becomeFirstResponder()
        } else if self.yourNameTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        } else if self.passwordTextField.isFirstResponder {
            passwordConfirmTextField.becomeFirstResponder()
        } else if self.passwordConfirmTextField.isFirstResponder {
            phoneNumberTextField.becomeFirstResponder()
        } else {
            phoneNumberTextField.resignFirstResponder()
        }
        return true
    }
}

//MARK: - Profile image - UIImagePickerController
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
    func setupProfileImage() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

