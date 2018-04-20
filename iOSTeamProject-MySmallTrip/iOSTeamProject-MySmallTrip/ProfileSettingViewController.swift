//
//  ProfileSettingViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 18..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class ProfileSettingViewController: UIViewController {
    
    private var table: UITableView?
    private var tableTitles: Dictionary<String, Array<String>> = [
        "basic" :
            [
                "이름",
                "연락처 변경"
        ],
        "loggedIn":
            [
                "이메일",
                "SNS 연동",
                "비밀번호 변경"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        setNaviItems()
        setTable()
        setLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("ProfileSetting VC is disposed")
    }
    
    // MARK: - Set Navigation Items
    private func setNaviItems() {
        self.navigationItem.title = "프로필 설정"
    }
    
    // Mark: - Set table view
    private func setTable() {
        self.table = UITableView()
        self.table!.delegate = self
        self.table!.dataSource = self
//        self.table!.register(ProfileSettingTableViewCell.self, forCellReuseIdentifier: "profileSettingCell")
        self.table!.register(UINib(nibName: "ProfileSettingTableViewCell", bundle: nil), forCellReuseIdentifier: "profileSettingCell")
        self.table!.separatorStyle = .singleLine
        self.table!.separatorColor = UIColor(displayP3Red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
        self.table!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.table!)
    }
    
    // MARK: - Set Layout
    private func setLayout() {
        guard let table = table else { return }
        
        let safeGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        
        table.heightAnchor.constraint(equalToConstant: 282).isActive = true
        table.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
}

extension ProfileSettingViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: The Number of Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableTitles.count
    }
    
    // MARK: The Number of Row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tableTitles["basic"]!.count
        } else {
            return tableTitles["loggedIn"]!.count
        }
    }
    
    // MARK: Row Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // MARK: Header Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var headerTitle: String?
        
        if section == 1 {
            headerTitle = "로그인 정보"
        }
        
        return headerTitle
    }
    
    // MARK: Header View
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        if section == 1 {
            view.textLabel?.font = UIFont.systemFont(ofSize: 12)
            view.textLabel?.textColor = UIColor(displayP3Red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
            view.textLabel?.textAlignment = .left
        }
    }
    
    // MARK: Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var headerHeight: CGFloat?
        
        if section == 1 {
            headerHeight = 29
        }
        return headerHeight ?? 0
    }
    
    // MARK: Footer Title
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var footerTitle: String?
        
        if section == 0 {
            footerTitle = " "
        }
        
        return footerTitle
    }
    
    // MARK: Footer Height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var footerHeight: CGFloat?
        
        if section == 0 {
            footerHeight = 33
        }
        
        return footerHeight ?? 0
    }
    
    // MARK: Row Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileSettingCell", for: indexPath) as! ProfileSettingTableViewCell
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.leftText = tableTitles["basic"]![0]
            cell.rightText = UserData.user.firstName
            cell.isUserInteractionEnabled = false // MARK: User Interaction Disable
            
        } else if indexPath.section == 0 && indexPath.row == 1 {
            cell.leftText = tableTitles["basic"]![1]
            cell.rightText = UserData.user.phoneNumber
            cell.accessoryType = .disclosureIndicator
            
        } else if indexPath.section == 1 && indexPath.row == 0 {
            cell.leftText = tableTitles["loggedIn"]![0]
            cell.rightText = UserData.user.email
            cell.isUserInteractionEnabled = false
            
        } else if indexPath.section == 1 && indexPath.row == 1 {
            cell.leftText = tableTitles["loggedIn"]![1]
            if let isFacebookUser = UserData.user.isFacebookUser {
                switch isFacebookUser {
                case true:
                    cell.rightText = "페이스북 연동됨"
                case false:
                    cell.rightText = "페이스북 연동 안됨"
                }
            } else {
                cell.rightText = nil
            }
            cell.isUserInteractionEnabled = false
            
        } else if indexPath.section == 1 && indexPath.row == 2 {
            cell.leftText = tableTitles["loggedIn"]![2]
            // cell.rightText = ""
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    // MARK: Row Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            // Empty
            tableView.deselectRow(at: indexPath, animated: true)
            
        } else if indexPath.section == 0 && indexPath.row == 1 {
            // TODO: 연락처 변경 view controller push
            let contactChangeVC = ContactChangeViewController()
            self.navigationController?.pushViewController(contactChangeVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
            
        } else if indexPath.section == 1 && indexPath.row == 0 {
            // Empty
            tableView.deselectRow(at: indexPath, animated: true)
            
        } else if indexPath.section == 1 && indexPath.row == 1 {
            // Empty
            tableView.deselectRow(at: indexPath, animated: true)
            
        } else if indexPath.section == 1 && indexPath.row == 2 {
            // TODO: 비밀번호 변경 view controller push
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
}
