//
//  SignUpViewController.swift
//  MySmallTrip
//
//  Created by KimYong Ho on 04/04/2018.
//  Copyright © 2018 OhTeam. All rights reserved.
//
/*******************************************************************
 [구현필요 내용 : 완료는 삭제됨]
 //회원가입 에러처리: response JSON으로 받아서 Alert 처리(msg는 Dic Value값)
 //User Info 서버로 전달, profile 사진은 url로 전달
 //비밀번호는 최소 8문자 이상 영문 + 숫자
 *******************************************************************/

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        yourNameTextField.delegate = self
        yourEmailTextField.delegate = self
        passwordConfirmTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordConfirmTextField.isSecureTextEntry = true
        
        createUIAndTouchKeaboardDisappear()
        setupProfileImage()
    }
    
    //MARK: - Head label
    @IBOutlet weak var singUpLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    
    //MARK: - TextField 및 View
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var yourNameTextField: UITextField!
    @IBOutlet weak var yourEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    //MARK: - Profile image 입력부
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
    
    //MARK: - CreateAccount 버튼 액션
    @IBOutlet weak var createAccountButton: UIButton!
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let urlString = "http://myrealtrip.hongsj.kr/sign-up/"
        //        let urlString = "https://api.lhy.kr/posts/"
        
        let parameter: Parameters = [
            "email" : yourEmailTextField.text!,
            "first_name" : yourNameTextField.text!,
            "password" : passwordTextField.text!,
            "password2" : passwordConfirmTextField.text!,
            "phone_number" : phoneNumberTextField.text!,
            "img_profile" : profileImage.image!
        ]
        
        //MARK: - 대용량 파일 업로드
//        Alamofire
        
        Alamofire.upload(
            multipartFormData: { multipartform in
                let emailData = self.yourEmailTextField.text!.data(using: .utf8)!
                multipartform.append(emailData, withName: "email")
                let nameData = self.yourNameTextField.text!.data(using: .utf8)!
                multipartform.append(nameData, withName: "first_name")
                let passwordData = self.passwordTextField.text!.data(using: .utf8)!
                multipartform.append(passwordData, withName: "password")
                let passwardData2 = self.passwordConfirmTextField.text!.data(using: .utf8)!
                multipartform.append(passwardData2, withName: "password2")
                let phoneNumberData = self.phoneNumberTextField.text!.data(using: .utf8)!
                multipartform.append(phoneNumberData, withName: "phone_number")
                
                if let image = self.profileImage.image {
                    let imageData = UIImageJPEGRepresentation(image, 1)
                    multipartform.append(imageData!, withName: "img_profile", mimeType: "image/jpg")
                }
        },
            to: urlString,
            method: .post,
            encodingCompletion: { result in
                switch result {
                case .success(let request, _, _):
                    request.responseData(completionHandler: { (response) in
                        switch response.result {
                        case .success:
                            print(response)
                        case .failure(let error):
                            print(error)
                        }
                    })
                case .failure(let error):
                    print(error)
                }
        })
        
        
        //        Alamofire
        //        .request(urlString, method: .post, parameters: parameter)
        //            .responseJSON { (response) in
        //                print(response.response?.statusCode)
        //                if let responseValue = response.result.value as! [String: Any]? {
        //                    print(responseValue.keys)
        //                    print(responseValue.values)
        //                }
        //        }
        
    }
    
    //MARK: - UI 구현부 및 키보드 willAppear & Disappear & touchDisappear
    private func createUIAndTouchKeaboardDisappear() {
        yourNameTextField.placeholder = "Your Name"
        yourEmailTextField.placeholder = "Your Email"
        passwordTextField.placeholder = "Password"
        passwordConfirmTextField.placeholder = "Password Confirm"
        phoneNumberTextField.placeholder = "Phone Number"
        createAccountButton.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardOberver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addKeyboardOberver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: .UIKeyboardWillShow,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: .UIKeyboardWillHide,
            object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let noti = notification.userInfo,
            let keyboardFrame = noti[UIKeyboardFrameBeginUserInfoKey] as? CGRect
            else { return }
        self.scrollView.contentInset.bottom = keyboardFrame.height + 10
    }
    @objc func keyboardWillHide(notification: Notification) {
        self.scrollView.contentInset = UIEdgeInsets.zero
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
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 1.5
        profileImage.clipsToBounds = true
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - 회원가입시 이벤트 처리
extension SignUpViewController {
    @IBAction func createAccountButton2(_ sender: Any) {
    }
}


