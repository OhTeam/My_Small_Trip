//
//  LogInResponse.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 16..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import Foundation

struct EmailLogIn: Codable {
    var token: String
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case token
        case user
    }
}

struct User: Codable {
    var primaryKey: Int
    var userName: String
    var email: String?
    var firstName: String
    var phoneNumber: String?
    var imgProfile: String?
    var isFacebookUser: Bool
    
    enum CodingKeys: String, CodingKey {
        case primaryKey = "pk"
        case userName = "username"
        case email
        case firstName = "first_name"
        case phoneNumber = "phone_number"
        case imgProfile = "img_profile"
        case isFacebookUser = "is_facebook_user"
    }
}
