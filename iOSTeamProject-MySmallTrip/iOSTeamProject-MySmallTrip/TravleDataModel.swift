//
//  TravleDataModel.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 11..
//  Copyright © 2018년 ohteam. All rights reserved.
//

struct PopularCity: Codable {
    let name: String
    let nationality: String
    let cityImage: String?
    let cityImageThumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case nationality
        case cityImage = "city_image"
        case cityImageThumbnail = "city_image_thumbnail"
    }
}

struct Travles: Codable {
    let pk: Int
    let name: String
    let city: City
    
    let price: Int
    let time: String
    let images: [travleImage]
}


struct City: Codable {
    let name: String
    let continent: String
    let nationality: String
    let city_image: String?
}


struct travleImage: Codable {
    let imageId: String
    let productImg: String
    let productImgThumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case productImg = "product_image"
        case productImgThumbnail = "product_image_thumbnail"
    }
}
