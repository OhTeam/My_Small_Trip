//
//  User.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 11..
//  Copyright © 2018년 ohteam. All rights reserved.
//

// user Singleton
class UserDataCenter {
    
    static var main: UserDataCenter = UserDataCenter()
    
    var user: User?
    var facebookUser: FacebookUser?
    
}


// url(String)
class UrlData {
    
    static var standards = UrlData()
    
    let basic = "http://myrealtrip.hongsj.kr"
    
    let signUp = "/sign-up/"
    let facebookLogin = "/facebook-login/"
    
    let travelMain = "/travel-information/"
    let travelSub = "/travel-information/"
    
}


// struct User
struct User: Codable {

    let pk: Int
    let userName: String
    let email: String
    let firstName: String
    let phoneNumber: String
    let profileImg: String
    let isFacebookUser: Bool
    
    enum CodingKeys: String, CodingKey {
        case pk
        case userName = "username"
        case email
        case firstName = "first_name"
        case phoneNumber = "phone_number"
        case profileImg = "img_profile"
        case isFacebookUser = "is_facebook_user"
    }
}


struct FacebookUser: Codable {
    let token: String
    let user: User
}
