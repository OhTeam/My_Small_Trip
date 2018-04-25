//
//  MyTripDataModel.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 26..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import Foundation

struct MyTrip: Codable {
    let pk: Int
    let travel_schedule: MyTripSchedule
    
    let member: User
    let is_canceled: Bool
    let total_price: Int
    let people: Int
    let concept: String?
    let age_generation: String?
    let personal_request: String?
}




struct MyTripSchedule: Codable {
    let travel_info: Info
    
    let reserved_people: Int
    let start_date: String
    let end_date: String?

}

struct Info: Codable {
    let pk: Int
    let name: String
    let city: City
    
    let price: Int
    let time: String
    let main_image: String
}
