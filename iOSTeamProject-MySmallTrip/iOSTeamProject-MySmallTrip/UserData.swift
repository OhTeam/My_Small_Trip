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
    
    private var token: String? // password token
    private var userName: String? // Normal emai or Facebook PIN Num
    private var email: String? //
    
    private init() {
        
    }
    
    var loginToken: String {
        return self.token ?? ""
    }
}
