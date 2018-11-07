//
//  ScheduleDateModel.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 25..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import Foundation

// 예약하기 관련 - 스케쥴 정보
struct TravelReservationInfo: Codable {
    let pk: Int
    let travelName: String
    let maxPeople: Int
    let reservedPeople: Int
    let schedules: [Schedule]
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case pk
        case travelName = "name"
        case maxPeople = "max_people"
        case reservedPeople = "people"
        case schedules = "travel_info"
        case user = "member"
    }
}

struct Schedule: Codable {
    let date: String
    let isPossible: Bool
    let reservedPeople: Int
    
    enum CodingKeys: String, CodingKey {
        case date = "start_date"
        case isPossible = "is_possible"
        case reservedPeople = "reserved_people"
    }
    
}

