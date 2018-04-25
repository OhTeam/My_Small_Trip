//
//  ServiceCenterViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 25..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class ServiceCenterViewController: UIViewController {

    private var firstView: UIView?
    private var secondView: UIView?
    private var separator: UIView?
    private var lowerDescription: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNaviItem()
        
        self.view.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        setComponents()
        setLayoutOfAllComponents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setNaviItem() {
        self.navigationItem.title = "고객센터"
    }
    
    private func setComponents() {
        self.firstView = setFirstView()
        self.secondView = setSecondView()
        self.separator = setSeparator()
        self.lowerDescription = setLowerDescription()
        
        self.view.addSubview(self.firstView!)
        self.view.addSubview(self.secondView!)
        self.view.addSubview(self.separator!)
        self.view.addSubview(self.lowerDescription!)
    }
    
    private func setLayoutOfAllComponents() {
        guard let firstView = firstView,
            let secondView = secondView,
            let separator = separator,
            let lowerDescription = lowerDescription
            else { return }
        
        let safeGuide = self.view.safeAreaLayoutGuide
        
        // First View
        firstView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        firstView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        firstView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        firstView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        
        // Second View
        secondView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor).isActive = true
        secondView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        secondView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        
        // Separator
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.bottomAnchor.constraint(equalTo: firstView.bottomAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: 7).isActive = true
        separator.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -7).isActive = true
        
        // Lower Description
        lowerDescription.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lowerDescription.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 50).isActive = true
        lowerDescription.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        lowerDescription.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        
    }
    
    private func setFirstView() -> UIView {
        // Set First View
        let firstTable = UIView()
        firstTable.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        firstTable.translatesAutoresizingMaskIntoConstraints = false
        
        let callImgView = UIImageView(image: UIImage(named: "phone"))
        callImgView.contentMode = .scaleAspectFit
        callImgView.translatesAutoresizingMaskIntoConstraints = false
        
        firstTable.addSubview(callImgView)
        
        let upperLabel = UILabel()
        upperLabel.text = "전화 문의하기"
        upperLabel.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
        upperLabel.textAlignment = .left
        upperLabel.font = UIFont.systemFont(ofSize: 12)
        upperLabel.translatesAutoresizingMaskIntoConstraints = false
        
        firstTable.addSubview(upperLabel)
        
        let lowerLabel = UILabel()
        lowerLabel.text = "1661 - 2860"
        lowerLabel.textColor = UIColor(displayP3Red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
        lowerLabel.textAlignment = .left
        lowerLabel.font = UIFont.systemFont(ofSize: 12)
        lowerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        firstTable.addSubview(lowerLabel)
        
        let callButton = UIButton()
        callButton.addTarget(self, action: #selector(touchFirstView(_:)), for: .touchUpInside)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        
        firstTable.addSubview(callButton)
        
        // Set Layout
        callImgView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        callImgView.widthAnchor.constraint(equalTo: callImgView.heightAnchor, multiplier: 1).isActive = true
        callImgView.centerYAnchor.constraint(equalTo: firstTable.centerYAnchor).isActive = true
        callImgView.leadingAnchor.constraint(equalTo: firstTable.leadingAnchor, constant: 22).isActive = true
        
        upperLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        upperLabel.topAnchor.constraint(equalTo: firstTable.topAnchor, constant: 7).isActive = true
        upperLabel.leadingAnchor.constraint(equalTo: callImgView.trailingAnchor, constant: 20).isActive = true
        upperLabel.trailingAnchor.constraint(equalTo: firstTable.trailingAnchor).isActive = true
        
        lowerLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        lowerLabel.topAnchor.constraint(equalTo: upperLabel.bottomAnchor).isActive = true
        lowerLabel.leadingAnchor.constraint(equalTo: callImgView.trailingAnchor, constant: 20).isActive = true
        lowerLabel.trailingAnchor.constraint(equalTo: firstTable.trailingAnchor).isActive = true
        
        callButton.topAnchor.constraint(equalTo: firstTable.topAnchor).isActive = true
        callButton.bottomAnchor.constraint(equalTo: firstTable.bottomAnchor).isActive = true
        callButton.leadingAnchor.constraint(equalTo: firstTable.leadingAnchor).isActive = true
        callButton.trailingAnchor.constraint(equalTo: firstTable.trailingAnchor).isActive = true
        
        return firstTable
    }
    
    private func setSecondView() -> UIView {
        // Set Second View
        let secondTable = UIView()
        secondTable.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        secondTable.translatesAutoresizingMaskIntoConstraints = false
        
        let emailImgView = UIImageView(image: UIImage(named: "email"))
        emailImgView.contentMode = .scaleAspectFit
        emailImgView.translatesAutoresizingMaskIntoConstraints = false
        
        secondTable.addSubview(emailImgView)
        
        let upperLabel = UILabel()
        upperLabel.text = "이메일 문의하기"
        upperLabel.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
        upperLabel.textAlignment = .left
        upperLabel.font = UIFont.systemFont(ofSize: 12)
        upperLabel.translatesAutoresizingMaskIntoConstraints = false
        
        secondTable.addSubview(upperLabel)
        
        let lowerLabel = UILabel()
        lowerLabel.text = "help@mysmalltrip.com"
        lowerLabel.textColor = UIColor(displayP3Red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
        lowerLabel.textAlignment = .left
        lowerLabel.font = UIFont.systemFont(ofSize: 12)
        lowerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        secondTable.addSubview(lowerLabel)
        
        let emailButton = UIButton()
        emailButton.addTarget(self, action: #selector(touchSecondView(_:)), for: .touchUpInside)
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        
        secondTable.addSubview(emailButton)
        
        // Set Layout
        emailImgView.heightAnchor.constraint(equalToConstant: 19).isActive = true
        emailImgView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        emailImgView.centerYAnchor.constraint(equalTo: secondTable.centerYAnchor).isActive = true
        emailImgView.leadingAnchor.constraint(equalTo: secondTable.leadingAnchor, constant: 20).isActive = true
        
        upperLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        upperLabel.topAnchor.constraint(equalTo: secondTable.topAnchor, constant: 7).isActive = true
        upperLabel.leadingAnchor.constraint(equalTo: emailImgView.trailingAnchor, constant: 20).isActive = true
        upperLabel.trailingAnchor.constraint(equalTo: secondTable.trailingAnchor).isActive = true
        
        lowerLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        lowerLabel.topAnchor.constraint(equalTo: upperLabel.bottomAnchor).isActive = true
        lowerLabel.leadingAnchor.constraint(equalTo: emailImgView.trailingAnchor, constant: 20).isActive = true
        lowerLabel.trailingAnchor.constraint(equalTo: secondTable.trailingAnchor).isActive = true
        
        emailButton.topAnchor.constraint(equalTo: secondTable.topAnchor).isActive = true
        emailButton.bottomAnchor.constraint(equalTo: secondTable.bottomAnchor).isActive = true
        emailButton.leadingAnchor.constraint(equalTo: secondTable.leadingAnchor).isActive = true
        emailButton.trailingAnchor.constraint(equalTo: secondTable.trailingAnchor).isActive = true
        
        return secondTable
    }
    
    private func setSeparator() -> UIView {
        // Set Separator
        let separator = UIView()
        separator.backgroundColor = UIColor(displayP3Red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        return separator
    }
    
    private func setLowerDescription() -> UILabel {
        let labelDescription = """
고객센터 운영시간은
한국기준 365일 오전 9시 ~ 오후 10시 입니다.
"""
        
        // Set Lower Description
        let description = UILabel()
        description.numberOfLines = 0
        description.text = labelDescription
        description.textColor = UIColor(displayP3Red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
        description.textAlignment = .center
        description.font = UIFont.systemFont(ofSize: 12)
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }
    
    // MARK: - Targets
    @objc private func touchFirstView(_ sender: UIButton) {
        // Animation of Button
        UIView.animate(withDuration: 0.2, animations: {
            self.firstView!.backgroundColor = UIColor(displayP3Red: 147/255, green: 147/255, blue: 147/255, alpha: 0.3)
        }) { (bool) in
            self.firstView!.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
            
            let callURL = URL(string: "tel://1661-2860")!
            if UIApplication.shared.canOpenURL(callURL) {
                UIApplication.shared.open(callURL)
            }
        }
    }
    
    @objc private func touchSecondView(_ sender: UIButton) {
        // Animation of Button
        UIView.animate(withDuration: 0.2, animations: {
            self.secondView!.backgroundColor = UIColor(displayP3Red: 147/255, green: 147/255, blue: 147/255, alpha: 0.3)
        }) { (bool) in
            self.secondView!.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
            
            let mailURL = URL(string: "mailto://help@mysmalltrip.com")!
            if UIApplication.shared.canOpenURL(mailURL) {
                UIApplication.shared.open(mailURL)
            }
        }
    }
}
