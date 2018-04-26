//
//  ProfileViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 10..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    
    private var profileView: UIView?
    private var profileImageView: UIImageView?
    private var uploadedImage: UIImage?
    private var nameLabel: UILabel?
    private var emailLabel: UILabel?
    private var tableView: UIView?
    private var buttonView: UIView?
    
    private var picker: UIImagePickerController?
    
    private var tableTitles: Dictionary<String, Array<String>> = [
        "profile" :
            [
                "프로필 설정",
                "나의 여행"
        ],
        "service" :
            [
                "고객센터",
                "FAQ"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
//        setNaviItems()
        
        // navi bar title - image add / back btn color change
        self.setNaviTitle()
        
        // navi bar backBtn title setting
        setNaviBackBtn()
        
        // MARK: Views Creation and Additon to Super View
        profileView = createProfileView()
        tableView = createTableView()
        buttonView = createButtonView()
        
        self.view.addSubview(profileView!)
        self.view.addSubview(tableView!)
        self.view.addSubview(buttonView!)
        
        setBasicLayout()
        
        self.picker = UIImagePickerController()
        picker!.delegate = self
        picker!.allowsEditing = true
        
    }
    
//        override func viewWillAppear(_ animated: Bool) {
//            if let index = self.table?.indexPathForSelectedRow {
//                self.table?.deselectRow(at: index, animated: true)
//            }
//        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("ProfileView VC is disposed")
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
        
//                profileImageView!.image = {
//                    guard let profileImage = UserData.user.profileImgData else { return UIImage(named: "avatar") }
//                    return UIImage(data: profileImage)
//                }()
        
        ({
            guard let profileImageView = self.profileImageView else { return }
            
            if let _ = UserData.user.imgProfile {
                if let profileImgData = UserData.user.profileImgData {
                    profileImageView.image = UIImage(data: profileImgData)
                    profileImageView.contentMode = .scaleAspectFit
                    return
                } else {
                    DispatchQueue.global().async {
                        while UserData.user.profileImgData == nil { }
                        DispatchQueue.main.async {
                            profileImageView.image = UIImage(data: UserData.user.profileImgData!)
                            profileImageView.contentMode = .scaleAspectFit
                        }
                    }
                }
            } else {
                profileImageView.image = UIImage(named: "avatar")
                profileImageView.contentMode = .scaleAspectFit
            }
        })()
        
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
//        TODO: 에러처리 공부 / DispatchQueue 공부 할 것 !!
//        let profileImageLink: URL = URL(string: imgProfile)!
//
//        // TODO: *** 실행 흐름 이해할 것!!
//        DispatchQueue.global().async {
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
        let logOutButton = UIButton()
        logOutButton.setTitle("LOG OUT", for: .normal)
        logOutButton.setTitleColor(UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        logOutButton.backgroundColor = UIColor(displayP3Red: 242/255, green: 92/255, blue: 98/255, alpha: 1)
        logOutButton.layer.cornerRadius = 10
        logOutButton.clipsToBounds = true
        logOutButton.addTarget(self, action: #selector(logOut(_:)), for: .touchUpInside)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonView.addSubview(logOutButton)
        
        //MARK: Layout inside Button View
        logOutButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        logOutButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 20).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 24).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: logOutButton.trailingAnchor, constant: 24).isActive = true
        
        return buttonView
    }
    
    // MARK: Print User Data
    func printDataOf(user: UserData) {
        print("token: " + (user.token ?? "nil"))
        if let primaryKey = user.primaryKey {
            print("primaryKey: \(primaryKey)")
        } else {
            print("primaryKey: nil")
        }
        print("userName: " + (user.userName ?? "nil"))
        print("email: " + (user.email ?? "nil"))
        print("firstName: " + (user.firstName ?? "nil"))
        print("phoneNumber: " + (user.phoneNumber ?? "nil"))
        print("imgProfile: " + (user.imgProfile ?? "nil"))
        if let isFacebookUser = user.isFacebookUser {
            print("isFacebookUser: \(isFacebookUser)")
        } else {
            print("isFacebookUser: nil")
        }
        if let _ = user.profileImgData {
            print("Data: OK")
        } else {
            print("Data: nil")
        }
        print("whishList: \(user.wishListPrimaryKeys)")
    }
    
    // MARK - Use Photo or Camera
    private func openLibray() {
        self.picker!.sourceType = .photoLibrary
        present(picker!, animated: false)
    }
    
    private func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker!.sourceType = .camera
            present(picker!, animated: false)
        } else {
            print("Camera is not available")
        }
    }
    
    // MARK: - Resize Image in the rectangle of 115 * 115
    private func reSizeImageWithRatio(image: UIImage?, targetSize: CGSize) -> UIImage? {
        guard let image = image else { return nil }
        let heightRatio = targetSize.height / image.size.height
        let widthRatio = targetSize.width / image.size.width
        
        var newSize: CGSize
        
        if heightRatio > widthRatio {
            newSize = CGSize(width: image.size.width * widthRatio, height: image.size.height * widthRatio)
        } else {
            newSize = CGSize(width: image.size.width * heightRatio, height: image.size.height * heightRatio)
        }
        
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: newRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    // Facebook Log Out
    private func logOutFacebook() {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
    }
    
    // MARK: - Targets
    // MARK: Function to change profile image
    @objc func changeUserProfileImage(_ sender: UIButton) {
        // needs to be modified
        print("Profile image button clicked")
        
        let photoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibray()
        }
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        photoAlert.addAction(library)
        photoAlert.addAction(camera)
        photoAlert.addAction(cancel)
        
        present(photoAlert, animated: true)
    }
    
    // MARK: Function to log out
    @objc func logOut (_ sender: UIButton) {
        guard UserData.user.isLoggedIn else { return }
        if UserData.user.isFacebookUser! {
            // TODO: Needs a function to log out from Facebook
            logOutFacebook()
            // if logging out from Facebook is succeeded...
            UserData.user.isLoggedIn = false
            self.tabBarController?.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            let logOutLink: String = "https://myrealtrip.hongsj.kr/logout/"
            let header = ["Authorization" : "Token " + (UserData.user.token ?? "")]
            print(UserData.user.token ?? "Token is nil on Log Out")
            importLibraries.connectionOfSeverForDataWith(logOutLink, method: .get, parameters: nil, headers: header, success: { (data, code) in
                UserData.user.isLoggedIn = false // user data logged out
                
                print("logged out")
                
                // to see logged user data
                // self.printDataOf(user: UserData.user)
                
                // YS
//                self.tabBarController?.presentingViewController?.dismiss(animated: true, completion: nil)
                
                // dev
                if self.tabBarController?.presentingViewController?.presentingViewController is SignUpViewController {
                    self.tabBarController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                } else {
                    self.tabBarController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                }
                
            }) { (error, code) in
                // token 유효성 잃었을 때 처리 방안
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Extension for UITableView of ProfileVC
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
            let myTripStoryboard = UIStoryboard(name: "Root", bundle: nil)
            let myTripVC = myTripStoryboard.instantiateViewController(withIdentifier: "MyTripViewController") as! MyTripViewController
            self.navigationController?.pushViewController(myTripVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            // TODO: Add 고객센터 view controller push
            let serviceCenterVC = ServiceCenterViewController()
            self.navigationController?.pushViewController(serviceCenterVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            // TODO: Add FAQ view controller push
            let faqStoryboard = UIStoryboard(name: "FAQ", bundle: nil)
            let faqVC = faqStoryboard.instantiateInitialViewController() as! FAQViewController
            self.navigationController?.pushViewController(faqVC, animated: true)
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

// MARK: - Extension of UIImagePickerController
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let profileImgChangeLing = "https://myrealtrip.hongsj.kr/members/info/img-change/"
        let header: Dictionary<String, String> = ["Authorization":"Token " + (UserData.user.token ?? "")]
        
        var tmpImage: UIImage?
        
        if let originImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            tmpImage = originImage
        } else if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            tmpImage = editedImage
        }
        
        guard let profileImageView = profileImageView, let resizedImage = self.reSizeImageWithRatio(image: tmpImage, targetSize: CGSize(width: 115, height: 115)), let data = UIImageJPEGRepresentation(resizedImage, 1)
            else {
                self.dismiss(animated: true, completion: nil)
                return
        }
        
        print("***IMG: \(resizedImage)")
        
        importLibraries.uploadOntoServer(multipartFormData: { (multiData) in
            multiData.append(data, withName: "img_profile", fileName: "profile.jpg", mimeType: "image/jpeg")
        }, usingThreshold: UInt64(), to: profileImgChangeLing, method: .patch, headers: header) { (encodingResult) in
            switch encodingResult {
            case .success(request: let upload, _, _):
                profileImageView.image = resizedImage
                
                upload.responseJSON(completionHandler: { (response) in
                    print(response)
                })

                print("Profile Photo is changed")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
//        if let selectedImage = tmpImage {
//            self.profileImageView!.image = selectedImage
//            self.uploadedImage = selectedImage
//            print(info)
        
            
            
//            if let data = UIImageJPEGRepresentation(selectedImages,1) {
//                let parameters: Parameters = [
//                    "access_token" : "YourToken"
//                ]
//                // You can change your image name here, i use NSURL image and convert into string
//                let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
//                let fileName = imageURL.absouluteString
//                // Start Alamofire
//                Alamofire.upload(multipartFormData: { multipartFormData in
//                    for (key,value) in parameters {
//                        multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
//                    }
//                    multipartFormData.append(data, withName: "avatar", fileName: fileName!,mimeType: "image/jpeg")
//                },
//                                 usingTreshold: UInt64.init(),
//                                 to: "YourURL",
//                                 method: .put,
//                                 encodingCompletion: { encodingResult in
//                                    switch encodingResult {
//                                    case .success(let upload, _, _):
//                                        upload.responJSON { response in
//                                            debugPrint(response)
//                                        }
//                                    case .failure(let encodingError):
//                                        print(encodingError)
//                                    }
//                })
//            }
//        }
        
        // TODO: - 확인해 볼것!
        dismiss(animated: true, completion: nil) // Warnig double touch and have to find solution !!!
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
