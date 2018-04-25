//
//  UserData.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 13..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import Foundation

class UserData {
    
    static var user: UserData = UserData()
    
    var calendarDate: String = ""
    
    private var _isLoggedIn: Bool = false {
        willSet {
            if newValue == false {
                self.setToken(token: nil)
                self.setPrimaryKey(primaryKey: nil)
                self.setUserName(userName: nil)
                self.setEmail(email: nil)
                self.setFirstName(firstName: nil)
                self.setPhoneNumber(phoneNumber: nil)
                self.setIsFacebookUser(isFacebookUser: nil)
                self.setImgProfile(imgProfile: nil)
                self.setProfileImgData(profileImgData: nil)
                self.setWishListPrimaryKeys(wishListPrimaryKeys: Array<Int>())
            }
        }
    } // Boolean value if logged in
    
    private var _token: String? // password token
    private var _primaryKey: Int? // User Primary Key
    private var _userName: String? // Normal emai or Facebook PIN Num
    private var _email: String? // Facebook email
    private var _firstName: String? // User Name
    private var _phoneNumber: String? // User Phone Number
    private var _imgProfile: String? // User Profile Image Link
    private var _isFacebookUser: Bool? // Boolean value if user is facebook user
    private var _profileImgData: Data? // Profile Image Data
    private var _wishListPrimaryKeys: Array<Int> = Array<Int>() // Wish List Primary Keys
    

    
    var isLoggedIn: Bool {
        set {
            self._isLoggedIn = newValue
        }
        get {
            return _isLoggedIn
        }
    }
    
    func setProfileImgData(profileImgData: Data?) {
        self._profileImgData = profileImgData
    }
    
    var profileImgData: Data? {
        return _profileImgData
    }
    
    private init() {
        
    }
    
    func setToken(token: String?) {
        self._token = token
    }
    
    var token: String? {
        return _token
    }
    
    func setPrimaryKey(primaryKey: Int?) {
        self._primaryKey = primaryKey
    }
    
    var primaryKey: Int? {
        return _primaryKey
    }
    
    func setUserName(userName: String?) {
        self._userName = userName
    }
    
    var userName: String? {
        return _userName
    }
    
    func setEmail(email: String?) {
        self._email = email
    }
    
    var email: String? {
        return _email
    }
    
    func setFirstName(firstName: String?) {
        self._firstName = firstName
    }
    
    var firstName: String? {
        return _firstName
    }
    
    func setPhoneNumber(phoneNumber: String?) {
        self._phoneNumber = phoneNumber
    }
    
    var phoneNumber: String? {
        return _phoneNumber
    }
    
    func setImgProfile(imgProfile: String?) {
        self._imgProfile = imgProfile
        
        guard let imgProfile = imgProfile else { return }
        
        // TODO: 에러처리 공부 / DispatchQueue 공부 할 것 !!
        let profileImageLink: URL = URL(string: imgProfile)!
        
        // TODO: *** 실행 흐름 이해할 것!!
        DispatchQueue.global().async {
            let profileImageData: NSData = NSData(contentsOf: profileImageLink)! // TODO: 여기도 공부 !!
            self.setProfileImgData(profileImgData: profileImageData as Data)
//            DispatchQueue.main.async {
//
//            }
        }
    }
    
    var imgProfile: String? {
        return _imgProfile
    }
    
    func setIsFacebookUser(isFacebookUser: Bool?) {
        self._isFacebookUser = isFacebookUser
    }
    
    var isFacebookUser: Bool? {
        return _isFacebookUser
    }
    
    func setWishListPrimaryKeys(wishListPrimaryKey: Int) {
        self._wishListPrimaryKeys.append(wishListPrimaryKey)
    }
    
    func setWishListPrimaryKeys(wishListPrimaryKeys: Array<Int>) {
        self._wishListPrimaryKeys = wishListPrimaryKeys
    }
    
    func removeWishListPrimaryKey(of index: Int) {
        self._wishListPrimaryKeys.remove(at: index)
    }
    
    var wishListPrimaryKeys: Array<Int> {
        return self._wishListPrimaryKeys
    }
}
