//
//  SMSAuthenticationViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 18..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class SMSAuthenticationViewController: UIViewController {
    
    private var tfDesLabel: UILabel?
    private var inputTextField: UITextField?
    private var invisibleLabel: UILabel?
    private var getAuthAgainView: UIView?
    private var getAuthAgainButton: UIButton?
    private var verifyButton: UIButton?
    
    private var movingHeightOfGetAuthAgainButton: NSLayoutConstraint?
    private var movingHeightOfBtn: NSLayoutConstraint?
    private let keyFrameHeight: CGFloat = 216
    
    var isVerified: Bool = true {
        didSet {
            guard let invisibleLabel = invisibleLabel,
                let movingHeightOfGetAuthAgainButton = movingHeightOfGetAuthAgainButton
                else { return }
            
            invisibleLabel.isHidden = isVerified
            if isVerified == false {
                movingHeightOfGetAuthAgainButton.constant = 35
            } else {
                movingHeightOfGetAuthAgainButton.constant = 0
            }
        }
    }
    
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
        print("SMSAuthentication VC is disposed")
    }
    
    // MARK: - Set Nvaigation Item
    private func setNaviItem() {
        self.navigationItem.title = "연락처 변경"
    }
    
    // MARK: - Set Components
    private func setComponents() {
        // TextField Description Label
        self.tfDesLabel = UILabel()
        self.tfDesLabel!.text = "인증코드"
        self.tfDesLabel!.font = UIFont.systemFont(ofSize: 12)
        self.tfDesLabel!.textAlignment = .left
        self.tfDesLabel!.textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        
        self.view.addSubview(tfDesLabel!)
        self.tfDesLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        // Input TextField
        self.inputTextField = UITextField()
        self.inputTextField!.delegate = self
        self.inputTextField!.placeholder = "인증코드를 입력해주세요."
        self.inputTextField!.font = UIFont.systemFont(ofSize: 16)
        self.inputTextField!.textAlignment = .left
        self.inputTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        self.inputTextField!.layer.borderWidth = 1
        self.inputTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        self.inputTextField!.layer.cornerRadius = 5
        self.inputTextField!.clipsToBounds = true
        self.inputTextField!.addTarget(self, action: #selector(moveBtnUp(_:)), for: .touchDown)
        
        self.view.addSubview(inputTextField!)
        self.inputTextField!.translatesAutoresizingMaskIntoConstraints = false
        
        // Invisible Notification Label
        self.invisibleLabel = UILabel()
        self.invisibleLabel!.text = "인증코드가 일치하지 않습니다."
        self.invisibleLabel!.font = UIFont.systemFont(ofSize: 12)
        self.invisibleLabel!.textColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
        self.invisibleLabel!.textAlignment = .left
        self.invisibleLabel!.isHidden = true // set hidden
        
        self.view.addSubview(invisibleLabel!)
        self.invisibleLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        // Get Authentication Again View
        self.getAuthAgainButton = UIButton()
//        getAuthAgainButton!.translatesAutoresizingMaskIntoConstraints = false
        self.getAuthAgainButton!.addTarget(self, action: #selector(getAuthAgain(_:)), for: .touchUpInside)
        self.getAuthAgainView = makePackageOfGetAuthBtn(btn: self.getAuthAgainButton!)
        self.getAuthAgainView!.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(getAuthAgainView!)
        
        // Verify Button
        self.verifyButton = UIButton()
        self.verifyButton!.setTitle("인증하기", for: .normal)
        self.verifyButton!.setTitleColor(UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        self.verifyButton!.titleLabel!.font = UIFont.systemFont(ofSize: 16)
        self.verifyButton!.titleLabel!.textAlignment = .center
        self.verifyButton!.backgroundColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
        self.verifyButton!.layer.cornerRadius = 10
        self.verifyButton!.clipsToBounds = true
        self.verifyButton!.addTarget(self, action: #selector(verifyAuth(_:)), for: .touchUpInside)
        
        self.view.addSubview(verifyButton!)
        self.verifyButton!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Set Layout of All Components
    private func setLayout() {
        guard let tfDesLabel = tfDesLabel,
            let inputTextField = inputTextField,
            let invisibleLabel = invisibleLabel,
            let getAuthAgainView = getAuthAgainView,
            let verifyButton = verifyButton
            else { return }
        
        let safeGuide = self.view.safeAreaLayoutGuide
        
        // TextField Description Label
        tfDesLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        tfDesLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 20).isActive = true
        inputTextField.topAnchor.constraint(equalTo: tfDesLabel.bottomAnchor, constant: 5).isActive = true
        tfDesLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: tfDesLabel.trailingAnchor, constant: 24).isActive = true
        
        // Input TextField
        inputTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        invisibleLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 12).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: 24).isActive = true
        
        // Invisible Label
        invisibleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        invisibleLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: invisibleLabel.trailingAnchor, constant: 24).isActive = true
        
        // Get Authentication Again View
        getAuthAgainView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        movingHeightOfGetAuthAgainButton = getAuthAgainView.topAnchor.constraint(equalTo: invisibleLabel.topAnchor)
        movingHeightOfGetAuthAgainButton!.isActive = true
        getAuthAgainView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: getAuthAgainView.trailingAnchor, constant: 24).isActive = true
        
        // Verify Button
        verifyButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        verifyButton.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        safeGuide.trailingAnchor.constraint(equalTo: verifyButton.trailingAnchor, constant: 24).isActive = true
        movingHeightOfBtn = safeGuide.bottomAnchor.constraint(equalTo: verifyButton.bottomAnchor, constant: 24)
        movingHeightOfBtn!.isActive = true
    }
    
    private func makePackageOfGetAuthBtn(btn: UIButton) -> UIView {
        let tmpView = UIView()
        
        let tmpLabel = UILabel()
        // -->
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        
        let attrs: Dictionary<NSAttributedStringKey, Any> = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12),
            NSAttributedStringKey.foregroundColor : UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1),
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue,
            NSAttributedStringKey.paragraphStyle : paragraph
        ]
        
        let attributedString = NSMutableAttributedString(string: "인증코드 다시 보내기", attributes: attrs)
        // <--
        tmpLabel.attributedText = attributedString
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tmpView.addSubview(tmpLabel)
        
        // Layout of Label
        tmpLabel.topAnchor.constraint(equalTo: tmpView.topAnchor).isActive = true
        tmpLabel.bottomAnchor.constraint(equalTo: tmpView.bottomAnchor).isActive = true
        tmpLabel.leadingAnchor.constraint(equalTo: tmpView.leadingAnchor).isActive = true
        tmpLabel.trailingAnchor.constraint(equalTo: tmpView.trailingAnchor).isActive = true
        
        // Set button Auto Resizing off
        btn.translatesAutoresizingMaskIntoConstraints = false
        tmpView.addSubview(btn)
        
        // Layout of Cover Button
        btn.topAnchor.constraint(equalTo: tmpView.topAnchor).isActive = true
        btn.bottomAnchor.constraint(equalTo: tmpView.bottomAnchor).isActive = true
        btn.leadingAnchor.constraint(equalTo: tmpView.leadingAnchor).isActive = true
        btn.trailingAnchor.constraint(equalTo: tmpView.trailingAnchor).isActive = true
        
        return tmpView
    }
    
    // MARK: - Targets
    @objc func moveBtnUp(_ sender: UITextField) {
        guard let movingHeightOfBtn = movingHeightOfBtn else { return }
        movingHeightOfBtn.constant = 24 + self.keyFrameHeight  // height should be changed with the real one
    }
    
    @objc func getAuthAgain(_ sender: UIButton) {
        // TODO: - Get authentication number again
        self.isVerified = true
        print("Test Again Button")
    }
    
    @objc func verifyAuth(_ sender: UIButton) {
        // TODO: - Verify authentication number
        self.isVerified = false
        print("Test Verify Button")
    }
}

extension SMSAuthenticationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let movingHeightOfBtn = movingHeightOfBtn else { return true }
        
        textField.resignFirstResponder()
        
        movingHeightOfBtn.constant = 24
        
        return true
    }
}
