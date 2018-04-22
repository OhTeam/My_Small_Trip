//
//  ReservationDateDataModel.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by KimYong Ho on 22/04/2018.
//  Copyright © 2018 ohteam. All rights reserved.
//

import Foundation

struct ReservationDate: Codable {
    var primaryKey: Int
    var name: String
    var maxPeople: Int
    var people: Int
    var schedules: Schedule
    
    enum CodingKeys: String, CodingKey {
        case primaryKey
        case name
        case maxPeople
        case people
        case schedules
    }
}

struct Schedule: Codable {
    var startDate: String
    var isPossible: Bool
    var reservedPeople: Int
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case isPossible = "is_possible"
        case reservedPeople = "reserved_people"
    }
}
