//
//  ProfileViewController.swift
//  MySmallTrip
//
//  Created by 최용석 on 2018. 4. 6..
//  Copyright © 2018년 OhTeam. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var titleView: UIView?
    var profileView: UIView?
    var tableView: UIView?
    var buttonView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        // MARK: - Views Creation and Additon to Super View
        titleView = createTitleView()
        profileView = createProfileView()
        tableView = createTableView()
        buttonView = createButtonView()
        
        self.view.addSubview(titleView!)
        self.view.addSubview(profileView!)
        self.view.addSubview(tableView!)
        self.view.addSubview(buttonView!)
        
        setBasicLayout()       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - SetBasicLayout
    private func setBasicLayout() {
        guard let titleView = self.titleView,
            let profileView = self.profileView,
            let tableView = self.tableView,
            let buttonView = self.buttonView
            else { return }
        
        let safeGuie = self.view.safeAreaLayoutGuide
        
        //Title View Layout
        titleView.centerXAnchor.constraint(equalTo: safeGuie.centerXAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: safeGuie.topAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: safeGuie.widthAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        // Profile View Layout
        profileView.centerXAnchor.constraint(equalTo: safeGuie.centerXAnchor).isActive = true
        profileView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        profileView.widthAnchor.constraint(equalTo: safeGuie.widthAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor).isActive = true
        
        // Table View Layout
        tableView.centerXAnchor.constraint(equalTo: safeGuie.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 196).isActive = true
        tableView.widthAnchor.constraint(equalTo: safeGuie.widthAnchor).isActive = true
        buttonView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        
        //Button View Layout
        buttonView.centerXAnchor.constraint(equalTo: safeGuie.centerXAnchor).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant: 147).isActive = true
        buttonView.widthAnchor.constraint(equalTo: safeGuie.widthAnchor).isActive = true
        safeGuie.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor).isActive = true
    }
    
    // MARK: - Title View
    private func createTitleView() -> UIView {
        let titleView = UIView()
//        titleView.backgroundColor = .yellow // temporary color to be recognized
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Image Creation
        let titleImageView: UIImageView = UIImageView(image: UIImage(named: "titleImage"))
        titleImageView.contentMode = .scaleAspectFill
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.addSubview(titleImageView)

        //MARK: Layout inside Title View
        titleImageView.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 18).isActive = true
        titleView.bottomAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 18).isActive = true
        titleImageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 134).isActive = true
        titleView.trailingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 133).isActive = true
        
        return titleView
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
        
        // Profile Image Creation
        let profileImageView: UIImageView = UIImageView()
        profileImageView.backgroundColor = .gray // temporary color
        profileImageView.layer.cornerRadius = 115/2
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileView.addSubview(profileImageView)
        
        // Name Label Creation
        let nameLabel: UILabel = UILabel()
        nameLabel.text = "Amanda Rhodes"
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = UIColor(displayP3Red: 50/255, green: 59/255, blue: 69/255, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        profileView.addSubview(nameLabel)
        
        // Email Label Creation
        let emailLabel: UILabel = UILabel()
        emailLabel.text = "contact@tripbooking.com"
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = UIColor(displayP3Red: 36/255, green: 37/255, blue: 61/255, alpha: 0.5)
        emailLabel.textAlignment = .center
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        profileView.addSubview(emailLabel)
        
        //MARK: Layout inside Porfile View
        // Profile Label // TODO: - subview를 둬서 상하 가운데로 맞추기 , name, email 도 맞게 조정 ~~~~~~~~~~~~
        profileLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 20).isActive = true
        profileImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 16).isActive = true
//        profileImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 16).isActive = true
        
        profileLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16).isActive = true
        profileView.trailingAnchor.constraint(equalTo: profileLabel.trailingAnchor, constant: 15)
        
        // Profile Image View
        profileImageView.centerXAnchor.constraint(equalTo: profileView.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 115).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1).isActive = true
        
        // Name Label
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profileView.centerXAnchor).isActive = true
        // insted of centerXAnchor as follows
//        nameLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 118).isActive = true
//        profileView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 117).isActive = true
        
        // Email Label
        emailLabel.centerXAnchor.constraint(equalTo: profileView.centerXAnchor).isActive = true
        // insted of centerXAnchor as follows
//        emailLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 107).isActive = true
//        profileView.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 106).isActive = true
        
        return profileView
    }
    
    // MARK: - Table View
    private func createTableView() -> UIView {
        let tableView = UIView()
//        tableView.backgroundColor = .green // temporary color to be recognized
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Table View Creation
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "profileCell")
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
        
        //MARK: Layout inside Table View
        signOutbutton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 20).isActive = true
        signOutbutton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 24).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: signOutbutton.trailingAnchor, constant: 24).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: signOutbutton.bottomAnchor, constant: 79).isActive = true
        
        
        return buttonView
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        // TODO: - change to switch ~~~~~~~~~~~~~~ or creation a function dealing with each cell
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.textLabel?.text = "프로필 설정"
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            cell.textLabel?.text = "나의 여행"
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            cell.textLabel?.text = "고객센터"
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            cell.textLabel?.text = "이용 약관"
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return " "
        } else {
            return ""
        }

    }
    
}
