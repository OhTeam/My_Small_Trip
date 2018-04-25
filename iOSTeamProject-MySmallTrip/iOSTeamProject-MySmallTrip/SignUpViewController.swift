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
    let urlString = "https://myrealtrip.hongsj.kr/sign-up/"
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        yourNameTextField.delegate = self
        yourEmailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordConfirmTextField.isSecureTextEntry = true
        
        dismissToMain.translatesAutoresizingMaskIntoConstraints = false
        let safeGuide = self.view.safeAreaLayoutGuide
        dismissToMain.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dismissToMain.widthAnchor.constraint(equalToConstant: 18).isActive = true
        dismissToMain.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 20).isActive = true
        dismissToMain.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 15).isActive = true
        
        
        createUIAndTouchKeaboardDisappear()
        setupProfileImage()
    }
    //MARK: - Dismiss To Main
    @IBOutlet weak var dismissToMain: UIButton!
    @IBAction func dismissToMain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    var nameCheck:Bool = false
    var emailCheck:Bool = false
    var passwordCheck:Bool = false
    var passwordCountCheck: Bool = false
    var password2Check:Bool = false
    var phoneNoCheck:Bool = false
    var phoneNoCountCheck:Bool = false
    
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
    

    //MARK: - 가입정보 데이터 전송
    func vaildName(nameText: String) -> Bool {
        let nameRegEx = "^[A-Za-z가-힣]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: nameText)
    }
    
    func validEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func validPassword(passwordNo: String) -> Bool {
        let regPassword = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", regPassword)
        return passwordTest.evaluate(with: passwordNo)
    }
    

    
    func validPhoneNo(phoneNo: String) -> Bool {
        let PhoneRegEx = "[0-9]{3}+[0-9]{3,4}+[0-9]{4}"
        let PhoneTest = NSPredicate(format:"SELF MATCHES %@", PhoneRegEx)
        return PhoneTest.evaluate(with: phoneNo)
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        //여기에 조건을 걸어서 안넘어가게 해줘 (guard let)
        if vaildName(nameText: yourNameTextField.text!) == false {
            nameCheck = false
        } else {
            nameCheck = true
        }
        if validEmail(email: yourEmailTextField.text!) == false {
            emailCheck = false
        } else {
            emailCheck = true
        }
        if validPassword(passwordNo: passwordTextField.text!) == false {
            passwordCheck = false
        } else {
            passwordCheck = true
        }
        if validPhoneNo(phoneNo: phoneNumberTextField.text!) == false {
            phoneNoCheck = false
        } else {
            phoneNoCheck = true
        }
        
        
        if nameCheck == true && emailCheck == true && passwordCheck == true && passwordCountCheck == true && phoneNoCheck == true && phoneNoCountCheck == true {
            guard let nameData = self.yourNameTextField.text!.data(using: .utf8) else { return }
            guard let emailData = self.yourEmailTextField.text!.data(using: .utf8) else { return }
            guard let passwordData = self.passwordTextField.text!.data(using: .utf8) else { return }
            guard let password2Data = self.passwordConfirmTextField.text!.data(using: .utf8) else { return }
            guard let phoneData = self.phoneNumberTextField.text!.data(using: .utf8) else { return }
            guard let imageData = UIImageJPEGRepresentation(self.profileImage.image!, 0.1) else { return }
            
            Alamofire
                .upload(
                    multipartFormData: { multipartform in
                        multipartform.append(emailData, withName: "email")
                        multipartform.append(nameData, withName: "first_name")
                        multipartform.append(passwordData, withName: "password")
                        multipartform.append(password2Data, withName: "password2")
                        multipartform.append(phoneData, withName: "phone_number")
                        multipartform.append(imageData, withName: "img_profile", fileName: "profileImage.png", mimeType: "image/png")
                },
                    to: urlString,
                    method: .post,
                    encodingCompletion: { result in
                        switch result {
                        case .success(let request, _, _):
                            request.responseJSON(completionHandler: { (res) in
                                print(res.response?.statusCode)
                                if let responseValue = res.result.value as! [String: Any]? {
                                    print(responseValue.keys)
                                    print(responseValue.values)
                                }
                                if res.response?.statusCode == 400, let responseValue = res.result.value as! [String: Any]? {
                                    let alertController = UIAlertController(title: "회원가입 실패", message: "\(responseValue.values)", preferredStyle: UIAlertControllerStyle.alert)
                                    let failureAlert = UIAlertAction(title: "확인", style: .default)
                                    alertController.addAction(failureAlert)
                                    self.present(alertController, animated: true, completion: nil)
                                } else {
                                    let alertController = UIAlertController(title: "회원가입 성공", message: "회원가입에 성공하였습니다.", preferredStyle: UIAlertControllerStyle.alert)
                                    let successAlert = UIAlertAction(title: "확인", style: .default, handler: { (sucessAlert) in
                                        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
//                                        let nextVC = loginStoryBoard.instantiateInitialViewController() as! LogInViewController
//                                        nextVC.emailTextField = yourEmailTextField.text
//                                        self.present(nextVC, animated: true, completion: nil)
                                    })
                                }
                                print(res.response)
                            })
                        case .failure(let error):
                            print(error)
                        }
                })
        }
        
    }
    
//MARK: - Textfield UI 및 키보드 willAppear & Disappear & touchDisappear
    private func createUIAndTouchKeaboardDisappear() {
        yourNameTextField.placeholder = "이름을 입력해 주세요"
        yourEmailTextField.placeholder = "email을 입력해 주세요"
        passwordTextField.placeholder = "특수문자+숫자+알파벳을 포함한 8자리 이상의 비밀번호"
        passwordConfirmTextField.placeholder = "비밀번호를 다시 입력해 주세요"
        phoneNumberTextField.placeholder = "휴대폰 번호 숫자만('-' 제외) 입력해 주세요"
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
        self.scrollView.contentInset.bottom = keyboardFrame.height + 48
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
            if vaildName(nameText: yourNameTextField.text!) == false {
                let alertController = UIAlertController(title: "이름 형식 확인", message: "한글 또는 영문인 이름을 사용하여 주세요.", preferredStyle: UIAlertControllerStyle.alert)
                let failureAlert = UIAlertAction(title: "확인", style: .default)
                alertController.addAction(failureAlert)
                self.present(alertController, animated: true, completion: nil)
            }
            yourEmailTextField.becomeFirstResponder()
        } else if self.yourEmailTextField.isFirstResponder {
            if validEmail(email: yourEmailTextField.text!) == false {
                let alertController = UIAlertController(title: "이메일 형식 확인", message: "반드시 본인의 유효한 이메일을 입력하여 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let failureAlert = UIAlertAction(title: "확인", style: .default)
                alertController.addAction(failureAlert)
                self.present(alertController, animated: true, completion: nil)
            }
            passwordTextField.becomeFirstResponder()
        } else if self.passwordTextField.isFirstResponder {
            if validPassword(passwordNo: passwordTextField.text!) == false {
                let alertController = UIAlertController(title: "비밀번호 확인", message: "8자리의 특수문자+숫자+알파벳을 넣어 입력하여 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let failureAlert = UIAlertAction(title: "확인", style: .default)
                alertController.addAction(failureAlert)
                self.present(alertController, animated: true, completion: nil)
            }
            passwordConfirmTextField.becomeFirstResponder()
        } else if self.passwordConfirmTextField.isFirstResponder {
            if passwordTextField.text! != passwordConfirmTextField.text! {
                let alertController = UIAlertController(title: "비밀번호 불일치", message: "동일한 비밀번호를 입력하여 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let failureAlert = UIAlertAction(title: "확인", style: .default)
                alertController.addAction(failureAlert)
                self.present(alertController, animated: true, completion: nil)
            }
            phoneNumberTextField.becomeFirstResponder()
        } else {
            if validPhoneNo(phoneNo: phoneNumberTextField.text!) == false {
                let alertController = UIAlertController(title: "휴대폰 번호 확인", message: "본인의 유효한 휴대폰 번호를 입력하여 주세요", preferredStyle: UIAlertControllerStyle.alert)
                let failureAlert = UIAlertAction(title: "확인", style: .default)
                alertController.addAction(failureAlert)
                self.present(alertController, animated: true, completion: nil)
            }
            phoneNumberTextField.resignFirstResponder()
        }
        return true
    }
}

//MARK: - 프로필 이미지 UIImagePickerController
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImage.image = editedImage
            print(info)
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = originalImage
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

//MARK: - Applying optional method to Textfield String? or nil
extension Optional where Wrapped == String {
    var nilIfEmpty: String? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}
