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
//        let profile = UIImageJPEGRepresentation(self.profileImage.image!, 0.1)?.base64EncodedData()
//        let parameter: Parameters = [
//            "email" : yourEmailTextField.text!,
//            "first_name" : yourNameTextField.text!,
//            "password" : passwordTextField.text!,
//            "password2" : passwordConfirmTextField.text!,
//            "phone_number" : phoneNumberTextField.text!,
//            "img_profile" : profile!
//        ]
//        print(parameter)
        
//MARK: - 가입정보 데이터 전송
//        Alamofire
//            .request(urlString, method: .post, parameters: parameter)
//            .responseJSON { (response) in
//                print(response.response?.statusCode)
//                if let responseValue = response.result.value as! [String:Any]? {
//                    print(responseValue.keys)
//                    print(responseValue.values)
//                }
//        }
        let emailData = self.yourEmailTextField.text!.data(using: .utf8)
        let nameData = self.yourNameTextField.text!.data(using: .utf8)
        let passwordData = self.passwordTextField.text!.data(using: .utf8)
        let password2Data = self.passwordConfirmTextField.text!.data(using: .utf8)
        let phoneData = self.phoneNumberTextField.text!.data(using: .utf8)
//        let imageData = UIImagePNGRepresentation(UIImage(named: "myImg")!)!
//        let imageData = UIImageJPEGRepresentation(UIImage(named: "myImgBig")!, 1)!
//        let imageData = UIImagePNGRepresentation(UIImage(named: "bigsize")!)!
//        let imageData = UIImageJPEGRepresentation(UIImage(named: "bigsize")!, 1)!
        let imageData = UIImageJPEGRepresentation(self.profileImage.image!, 0.1)
//        let imageData = UIImageJPEGRepresentation(UIImage(named: "soBig")!, 0.9)!
        print(imageData)
        
        Alamofire.upload(
            multipartFormData: { multipartform in
                multipartform.append(emailData!, withName: "email")
                multipartform.append(nameData!, withName: "first_name")
                multipartform.append(passwordData!, withName: "password")
                multipartform.append(password2Data!, withName: "password2")
                multipartform.append(phoneData!, withName: "phone_number")
//                multipartform.append(imageData, withName: "img_profile", fileName: "myImg.png", mimeType: "image/png")
//                multipartform.append(imageData, withName: "img_profile", fileName: "myImgBig.jpg", mimeType: "image/jpg")
//                multipartform.append(imageData, withName: "img_profile", fileName: "bigsize.png", mimeType: "image/png")
//                multipartform.append(imageData, withName: "img_profile", fileName: "bigsize.jpg", mimeType: "image/jpg")
                multipartform.append(imageData!, withName: "img_profile", fileName: "profileImage.png", mimeType: "image/png")
//                multipartform.append(imageData, withName: "img_profile", fileName: "soBig.jpg", mimeType: "image/jpg")
        },
            to: urlString,
            method: .post,
            encodingCompletion: { result in
                switch result {
                case .success(let request, _, _):
                    request.responseJSON(completionHandler: { (response) in
                        print(response)
                        print(response.result)
                        print(response.response)
                    })
                case .failure(let error):
                    print(error)
                }
        })
    }
    
//MARK: - Textfield UI 및 키보드 willAppear & Disappear & touchDisappear
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
        self.scrollView.contentInset.bottom = keyboardFrame.height
    }
    @objc func keyboardWillHide(notification: Notification) {
        self.scrollView.contentInset = UIEdgeInsets.zero
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - textFieldShouldReturn 구현부
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if self.yourNameTextField.isFirstResponder {
            yourEmailTextField.becomeFirstResponder()
        } else if self.yourEmailTextField.isFirstResponder {
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

//MARK: - 프로필 이미지 UIImagePickerController
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
    func setupProfileImage() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - 회원가입시 이벤트 처리
//extension SignUpViewController {
//    func isValidEmailAddress(email: String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//        if email {
//            return emailTest.evaluate(with: email)
//        } else {
//        let alert = UIAlertController(title: "기입정보 오류", message: "이메일 형식이 잘못되었습니다.", preferredStyle: .actionSheet)
//        let email = UIAlertAction(title: "Email", style: .default)
//        alert.addAction(email)
//        present(alert, animated: true, completion: nil)
//        }
//    }
//}

/***
 // 아이디 체크 정규식
 
 var regId = /^[a-z0-9_-]\w{5,20}$/;
 
 
 
 // 비밀번호 길이 체크 정규식
 
 var regPassword = /^\w[6,16]$/;
 
 
 
 // 비밀번호 조합(영문, 숫자) 및 길이 체크 정규식
 
 var regPassword = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,16}$/;
 
 
 
 // 이메일 체크 정규식
 
 var regEmail=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
 
 
 
 // 휴대폰번호 정규식
 
 var regMobile = /^01([016789]?)-?([0-9]{3,4})-?([0-9]{4})$/;
 
 
 
 // 숫자만 사용 정규식
 
 var regNumber = /^\d+$/;
 ***/


