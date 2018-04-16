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
    private var inputTextField: UITextField?
    private var actionButton: UIButton?
    
    private var movingHeightOfBtn: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviItem()
        setComponents()
        setLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setNaviItem() {
        self.navigationItem.title = "연락처 변경"
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "titleImage"), style: .done, target: self, action: #selector(popThis(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "dismiss")))
    }
    
    // MARK: - Set Components
    private func setComponents() {
        // Upper Description Label
        upperDesLabel = UILabel()
        upperDesLabel!.text = "새 휴대폰 번호를 입력하고 인증해주세요."
        upperDesLabel!.font = UIFont.systemFont(ofSize: 14)
        upperDesLabel!.textAlignment = .left
        upperDesLabel!.textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        self.view.addSubview(upperDesLabel!)
        upperDesLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        // TextField Description Label
        tfDesLabel = UILabel()
        tfDesLabel!.text = "휴대폰 번호"
        tfDesLabel!.font = UIFont.systemFont(ofSize: 12)
        tfDesLabel!.textAlignment = .left
        tfDesLabel!.textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        self.view.addSubview(tfDesLabel!)
        tfDesLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        // Input TextField
        inputTextField = UITextField()
        inputTextField!.placeholder = "전화번호를 입력하세요."
        inputTextField!.font = UIFont.systemFont(ofSize: 16)
        inputTextField!.textAlignment = .left
        inputTextField!.textColor = UIColor(displayP3Red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        inputTextField!.layer.borderWidth = 1
        inputTextField!.layer.borderColor = UIColor(displayP3Red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        inputTextField!.layer.cornerRadius = 5
        inputTextField!.clipsToBounds = true
        self.view.addSubview(inputTextField!)
        inputTextField!.translatesAutoresizingMaskIntoConstraints = false
        
        // Action Button
        actionButton = UIButton()
        actionButton!.setTitle("문자로 인증코드 보내기", for: .normal)
        actionButton!.setTitleColor(UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        actionButton!.titleLabel!.font = UIFont.systemFont(ofSize: 16)
        actionButton!.titleLabel!.textAlignment = .center
        actionButton!.backgroundColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
        actionButton!.layer.cornerRadius = 10
        actionButton!.clipsToBounds = true
        self.view.addSubview(actionButton!)
        actionButton!.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Set Layout of All Components
    private func setLayout() {
        guard let upperDesLabel = upperDesLabel,
            let tfDesLabel = tfDesLabel,
            let inputTextField = inputTextField,
            let actionButton = actionButton
            else { return }
        
        let safeGuide = self.view.safeAreaLayoutGuide
        
        // Upper Description Label
        upperDesLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        upperDesLabel.widthAnchor.constraint(equalToConstant: 218).isActive = true
        upperDesLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 20).isActive = true
        upperDesLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 16).isActive = true
        
        // TextField Description Label
        tfDesLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        tfDesLabel.widthAnchor.constraint(equalToConstant: 54).isActive = true
        tfDesLabel.topAnchor.constraint(equalTo: upperDesLabel.bottomAnchor, constant: 34).isActive = true
        tfDesLabel.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 24).isActive = true
        
        // Input TextField
        inputTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        inputTextField.widthAnchor.constraint(equalToConstant: 327).isActive = true
        inputTextField.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: tfDesLabel.bottomAnchor, constant: 5).isActive = true
        
        // Action Button
        actionButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 327).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
        movingHeightOfBtn = safeGuide.bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 24)
        movingHeightOfBtn?.isActive = true
    }
    
    // MARK: - Targets
    @objc func popThis(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
