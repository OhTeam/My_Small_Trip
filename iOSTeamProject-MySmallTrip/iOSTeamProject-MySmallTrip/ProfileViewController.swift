//
//  ProfileViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 10..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    private var profileView: UIView?
    private var profileImageView: UIImageView?
    private var nameLabel: UILabel?
    private var emailLabel: UILabel?
    private var tableView: UIView?
    private var buttonView: UIView?
    
    private var tableTitles: Dictionary<String, Array<String>> = [
        "profile" :
            [
                "프로필 설정",
                "나의 여행"
        ],
        "service" :
            [
                "고객센터",
                "이용 약관"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        setNaviItems()
        
        // MARK: Views Creation and Additon to Super View
        profileView = createProfileView()
        tableView = createTableView()
        buttonView = createButtonView()
        
        self.view.addSubview(profileView!)
        self.view.addSubview(tableView!)
        self.view.addSubview(buttonView!)
        
        setBasicLayout()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        if let index = self.table?.indexPathForSelectedRow {
//            self.table?.deselectRow(at: index, animated: true)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Set Navigation Items
    private func setNaviItems() {
        // Prepare for Navigation Controller
        // ㄴ> titleView without any anchor
        self.navigationItem.titleView = {
            () -> UIImageView in
            let tmpImageView = UIImageView(image: UIImage(named: "titleImage"))
            return tmpImageView
        }()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem?.tintColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
    }
    
    // MARK: - Set Basic Layout
    private func setBasicLayout() {
        guard let profileView = self.profileView,
            let tableView = self.tableView,
            let buttonView = self.buttonView
            else { return }
        
        let safeGuie = self.view.safeAreaLayoutGuide
        
        // Profile View Layout
        profileView.widthAnchor.constraint(equalTo: safeGuie.widthAnchor).isActive = true
        profileView.centerXAnchor.constraint(equalTo: safeGuie.centerXAnchor).isActive = true
        profileView.topAnchor.constraint(equalTo: safeGuie.topAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor).isActive = true
        
        // Table View Layout
        tableView.heightAnchor.constraint(equalToConstant: 196).isActive = true
        tableView.widthAnchor.constraint(equalTo: safeGuie.widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: safeGuie.centerXAnchor).isActive = true
        buttonView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        
        //Button View Layout
        buttonView.heightAnchor.constraint(equalToConstant: 91).isActive = true
        buttonView.widthAnchor.constraint(equalTo: safeGuie.widthAnchor).isActive = true
        buttonView.centerXAnchor.constraint(equalTo: safeGuie.centerXAnchor).isActive = true
        safeGuie.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor).isActive = true
    }
    
    // MARK: - Profile View
    private func createProfileView() -> UIView {
        let profileView = UIView()
        //        profileView.backgroundColor = .red // temporary color to be recognized
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        // Profile Label Creation
        let profileLabel: UILabel = UILabel()
        profileLabel.text = "PROFILE"
        profileLabel.font = UIFont.systemFont(ofSize: 14)
        profileLabel.textColor = UIColor(displayP3Red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        profileLabel.textAlignment = .left
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        
        profileView.addSubview(profileLabel)
        
        // Profile Subview Creation
        let profileSubview: UIView = UIView()
        profileSubview.translatesAutoresizingMaskIntoConstraints = false
        
        profileView.addSubview(profileSubview)
        
        // Moving Profile Subview Creation
        let movingProfileSubview: UIView = UIView()
        movingProfileSubview.translatesAutoresizingMaskIntoConstraints = false
        
        profileSubview.addSubview(movingProfileSubview)
        
        // Profile Image Creation
        profileImageView = UIImageView()
        profileImageView!.image = {
            guard let profileImage = UserData.user.profileImgData else { return UIImage(named: "avatar") }
            return UIImage(data: profileImage)
        }()
//        loadProfileImage() // profile image setting
        profileImageView!.layer.cornerRadius = 115/2
        profileImageView!.clipsToBounds = true
        profileImageView!.translatesAutoresizingMaskIntoConstraints = false
        
        movingProfileSubview.addSubview(profileImageView!)
        
        // Profile Image Button Creation, which changes profile photo
        let pfImgButton: UIButton = UIButton()
        pfImgButton.backgroundColor = .clear
        pfImgButton.layer.cornerRadius = 115/2
        pfImgButton.clipsToBounds = true
        pfImgButton.addTarget(self, action: #selector(changeUserProfileImage(_:)), for: .touchUpInside)
        pfImgButton.translatesAutoresizingMaskIntoConstraints = false

        movingProfileSubview.addSubview(pfImgButton)
        
        // Name Label Creation
        nameLabel = UILabel()
        nameLabel!.text = UserData.user.firstName // user name logged In
        nameLabel!.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel!.textColor = UIColor(displayP3Red: 50/255, green: 59/255, blue: 69/255, alpha: 1)
        nameLabel!.textAlignment = .center
        nameLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        movingProfileSubview.addSubview(nameLabel!)
        
        // Email Label Creation
        emailLabel = UILabel()
        emailLabel!.text = UserData.user.email // user email logged In
        emailLabel!.font = UIFont.systemFont(ofSize: 14)
        emailLabel!.textColor = UIColor(displayP3Red: 36/255, green: 37/255, blue: 61/255, alpha: 0.5)
        emailLabel!.textAlignment = .center
        emailLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        movingProfileSubview.addSubview(emailLabel!)
        
        //MARK: Layout inside Porfile View
        // Profile Label
        profileLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        profileLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 20).isActive = true
        profileLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16).isActive = true
        profileView.trailingAnchor.constraint(equalTo: profileLabel.trailingAnchor, constant: 15).isActive = true
        
        // ㄴ> Profile Subview
        profileSubview.topAnchor.constraint(equalTo: profileLabel.bottomAnchor).isActive = true
        profileSubview.bottomAnchor.constraint(equalTo: profileView.bottomAnchor).isActive = true
        profileSubview.leadingAnchor.constraint(equalTo: profileView.leadingAnchor).isActive = true
        profileSubview.trailingAnchor.constraint(equalTo: profileView.trailingAnchor).isActive = true
        
        // ㄴㅡ> Moving Profile Subview
        movingProfileSubview.heightAnchor.constraint(equalToConstant: 168).isActive = true
        movingProfileSubview.centerYAnchor.constraint(equalTo: profileSubview.centerYAnchor).isActive = true
        movingProfileSubview.leadingAnchor.constraint(equalTo: profileSubview.leadingAnchor).isActive = true
        movingProfileSubview.trailingAnchor.constraint(equalTo: profileSubview.trailingAnchor).isActive = true
        
        // ㄴㅡㅡ> Profile Image View
        profileImageView!.heightAnchor.constraint(equalToConstant: 115).isActive = true
        profileImageView!.widthAnchor.constraint(equalTo: profileImageView!.heightAnchor, multiplier: 1).isActive = true
        profileImageView!.centerXAnchor.constraint(equalTo: movingProfileSubview.centerXAnchor).isActive = true
        profileImageView!.topAnchor.constraint(equalTo: movingProfileSubview.topAnchor).isActive = true
        
        // ㄴㅡㅡ> Profile Image Button
        pfImgButton.heightAnchor.constraint(equalToConstant: 115).isActive = true
        pfImgButton.widthAnchor.constraint(equalTo: pfImgButton.heightAnchor, multiplier: 1).isActive = true
        pfImgButton.centerXAnchor.constraint(equalTo: movingProfileSubview.centerXAnchor).isActive = true
        pfImgButton.topAnchor.constraint(equalTo: movingProfileSubview.topAnchor).isActive = true
        
        // ㄴㅡㅡ> Name Label
        nameLabel!.centerXAnchor.constraint(equalTo: movingProfileSubview.centerXAnchor).isActive = true
        nameLabel!.topAnchor.constraint(equalTo: profileImageView!.bottomAnchor, constant: 12).isActive = true
        emailLabel!.topAnchor.constraint(equalTo: nameLabel!.bottomAnchor).isActive = true
        
        // ㄴㅡㅡ> Email Label
        emailLabel!.centerXAnchor.constraint(equalTo: movingProfileSubview.centerXAnchor).isActive = true
        
        return profileView
    }
    
    // MARK: Load Profile Image
//    private func loadProfileImage() {
//        guard let imgProfile = UserData.user.imgProfile else {
//            self.profileImageView?.image = UIImage.init(named: "avatar")
//            return
//        }
//
//        let profileImageLink: URL = URL(string: imgProfile)! // TODO: 에러처리 공부 / DispatchQueue 공부 할 것 !!
//
//        // TODO: *** 실행 흐름 이해할 것!!
//        DispatchQueue.global().async {
//            print(profileImageLink)
//            let profileImageData: NSData = NSData(contentsOf: profileImageLink)! // TODO: 여기도 공부 !!
//            DispatchQueue.main.async {
//                self.profileImageView!.image = UIImage(data: profileImageData as Data)
//            }
//        }
//    }
    
    // MARK: - Table View
    private func createTableView() -> UIView {
        let tableView = UIView()
        //        tableView.backgroundColor = .green // temporary color to be recognized
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Table View Creation
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "profileViewCell")
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.addSubview(table)
        
        //MARK: Layout inside Table View
        table.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        
        return tableView
    }
    
    // MARK: - Button View
    private func createButtonView() -> UIView {
        let buttonView = UIView()
        //        buttonView.backgroundColor = .blue // temporary color to be recognized
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        // Button Creation
        let signOutbutton = UIButton()
        signOutbutton.setTitle("SIGN OUT", for: .normal)
        signOutbutton.setTitleColor(UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        signOutbutton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        signOutbutton.backgroundColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
        signOutbutton.layer.cornerRadius = 10
        signOutbutton.clipsToBounds = true
        signOutbutton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonView.addSubview(signOutbutton)
        
        //MARK: Layout inside Button View
        signOutbutton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        signOutbutton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 20).isActive = true
        signOutbutton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 24).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: signOutbutton.trailingAnchor, constant: 24).isActive = true
        
        return buttonView
    }
    
    // MARK: - Targets
    @objc func changeUserProfileImage(_ sender: UIButton) {
        // needs to be modified
        print("Profile image button clicked")
    }
}

// MARK: - Extension of ProfileVC
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: The Number of Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableTitles.count
    }
    
    // MARK: The Number of Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tableTitles["profile"]!.count
        } else {
            return tableTitles["service"]!.count
        }
    }
    
    // MARK: Row Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileViewCell", for: indexPath)
        // TODO: switch문으로 교체 아니면 각 셀 처리할 메소드 생성 고민 !!
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.textLabel?.text = tableTitles["profile"]![0]
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            cell.textLabel?.text = tableTitles["profile"]![1]
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            cell.textLabel?.text = tableTitles["service"]![0]
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            cell.textLabel?.text = tableTitles["service"]![1]
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // TODO: accessoryButton 눌렀을 때 기능 찾기 !!
//    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        if indexPath.section == 0 && indexPath.row == 0 {
//            let tmpVC = UIViewController()
//            tmpVC.view.backgroundColor = .white
//            self.navigationItem.backBarButtonItem = UIBarButtonItem()
//            self.navigationItem.backBarButtonItem?.title = ""
//
//            self.navigationController?.pushViewController(tmpVC, animated: true)
//        }
//
//        if indexPath.section == 0 && indexPath.row == 1 {
//
//        }
//
//        if indexPath.section == 1 && indexPath.row == 0 {
//
//        }
//
//        if indexPath.section == 1 && indexPath.row == 1 {
//
//        }
//    }
    
    // MARK: Row Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tableView.allowsSelection = false // prevention from row selection
        if indexPath.section == 0 && indexPath.row == 0 {
            // TODO: Add 프로필 설정 view controller push
            let profileSettingVC = ProfileSettingViewController()
            self.navigationController?.pushViewController(profileSettingVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            // TODO: Add 나의 여행 view controller push
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            // TODO: Add 고객센터 view controller push
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            // TODO: Add 이용관약관 view controller push
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: Row Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // TODO: 이부분 string 없이 어떻게 처리 할 수 있는지 확인 할 것 !!
    // MARK: Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 20
        } else {
            return 0
        }
    }
    
    // MARK: Header Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return " "
        } else {
            return ""
        }
    }
}
