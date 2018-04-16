//
//  TravleDataModel.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 11..
//  Copyright © 2018년 ohteam. All rights reserved.
//

// url(String)
class UrlData {
    
    static var standards = UrlData()
    
    let basic = "http://myrealtrip.hongsj.kr"
    
    let signUp = "/sign-up/"
    let facebookLogin = "/facebook-login/"
    
    let travelMain = "/travel-information/"
}


// 인기 여행지
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

// 여행상품
struct Travel: Codable {
    let pk: Int
    let name: String // 여행상품 명
    let city: City
    
    let price: Int
    let time: String
    let images: [TravelImage]
}


// 도시 정보
struct City: Codable {
    let name: String // 도시명 (ex. 베를린)
    let continent: String // 대륙명 (ex. 유럽)
    let nationality: String // 국가명 (ex. 독일)
    let cityImage: String?
    let cityImageThumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case continent
        case nationality
        case cityImage = "city_image"
        case cityImageThumbnail = "city_image_thumbnail"
    }
}

// 여행상품 이미지
struct TravelImage: Codable {
    let imageId: Int
    let productImg: String
    let productImgThumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case productImg = "product_image"
        case productImgThumbnail = "product_image_thumbnail"
    }
}