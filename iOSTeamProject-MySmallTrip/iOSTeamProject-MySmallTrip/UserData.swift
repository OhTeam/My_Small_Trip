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
    
    private var _token: String? // password token
    private var _primaryKey: Int? // User Primary Key
    private var _userName: String? // Normal emai or Facebook PIN Num
    private var _email: String? // Facebook email
    private var _firstName: String? // User Name
    private var _phoneNumber: String? // User Phone Number
    private var _imgProfile: String? // User Profile Image Link
    private var _isFacebookUser: Bool? // Boolean value if user is facebook user
    
    
    private init() {
        
    }
    
    func setToken(token: String) {
        self._token = token
    }
    
    var token: String? {
        guard let _token = _token else { return nil }
        return _token
    }
    
    func setPrimaryKey(primaryKey: Int) {
        self._primaryKey = primaryKey
    }
    
    var primaryKey: Int? {
        guard let _primaryKey = _primaryKey else { return nil }
        return _primaryKey
    }
    
    func setUserName(userName: String) {
        self._userName = userName
    }
    
    var userName: String? {
        guard let _userName = _userName else { return nil }
        return _userName
    }
    
    func setEmail(email: String) {
        self._email = email
    }
    
    var email: String? {
        guard let _email = _email else { return nil }
        return _email
    }
    
    func setFirstName(firstName: String) {
        self._firstName = firstName
    }
    
    var firstName: String? {
        guard let _firstName = _firstName else { return nil }
        return _firstName
    }
    
    func setPhoneNumber(phoneNumber: String) {
        self._phoneNumber = phoneNumber
    }
    
    var phoneNumber: String? {
        guard let _phoneNumber = _phoneNumber else { return nil }
        return _phoneNumber
    }
    
    func setImgProfile(imgProfile: String?) {
        self._imgProfile = imgProfile
    }
    
    var imgProfile: String? {
        guard let _imgProfile = _imgProfile else { return nil }
        return _imgProfile
    }
    
    func setIsFacebookUser(isFacebookUser: Bool) {
        self._isFacebookUser = isFacebookUser
    }
    
    var isFacebookUser: Bool? {
        guard let _isFacebookUser = _isFacebookUser else { return nil }
        return _isFacebookUser
    }
}
