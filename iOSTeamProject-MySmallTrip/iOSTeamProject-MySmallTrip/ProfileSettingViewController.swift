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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        var headerTitle: String?

        if section == 1 {
            headerTitle = "로그인 정보"
        }

        return headerTitle
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        if section == 1 {
            view.textLabel?.font = UIFont.systemFont(ofSize: 12)
            view.textLabel?.textColor = UIColor(displayP3Red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
            view.textLabel?.textAlignment = .left            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var headerHeight: CGFloat?
        
        if section == 1 {
            headerHeight = 29
        }
        return headerHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var footerTitle: String?
        
        if section == 0 {
            footerTitle = " "
        }
        
        return footerTitle
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var footerHeight: CGFloat?
        
        if section == 0 {
            footerHeight = 33
        }
        
        return footerHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileSettingCell", for: indexPath) as! ProfileSettingTableViewCell
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.leftText = "이름"
            cell.rightText = "Amanda Rhodes"
            cell.isUserInteractionEnabled = false // MARK: User Interaction Enabled
        } else if indexPath.section == 0 && indexPath.row == 1 {
            cell.leftText = "연락처 변경"
            cell.rightText = "010-5835-0602"
            cell.accessoryType = .disclosureIndicator
        } else if indexPath.section == 1 && indexPath.row == 0 {
            cell.leftText = "이메일"
            cell.rightText = "contact@tripbooking.com"
            cell.isUserInteractionEnabled = false
        } else if indexPath.section == 1 && indexPath.row == 1 { // MARK: isFacebookUser
            cell.leftText = "SNS 연동"
            cell.rightText = "페이스북 연동됨"
            cell.isUserInteractionEnabled = false
        } else if indexPath.section == 1 && indexPath.row == 2 {
            cell.leftText = "이메일"
            cell.rightText = "contact@tripbooking.com"
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
}
