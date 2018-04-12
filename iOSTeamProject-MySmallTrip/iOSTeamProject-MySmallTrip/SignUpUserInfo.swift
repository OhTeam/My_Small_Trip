//
//  SignUpUserInfo.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by KimYong Ho on 12/04/2018.
//  Copyright © 2018 ohteam. All rights reserved.
//

import Foundation
final class SignUpUserInfoModel {
    struct SignUpUserInfo: Codable {
        var email: String
        var name: String
        var password: String
        var password2: String
        var phoneNo: String
        
        enum CodingKeys: String, CodingKey {
            case email = "email"
            case name = "first_name"
            case password = "password"
            case password2 = "password2"
            case phoneNo = "phone_number"
        }
    }
}
