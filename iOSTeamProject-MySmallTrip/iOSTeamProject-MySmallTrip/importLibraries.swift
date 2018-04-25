//
//  importLibraries.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 21..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import Foundation
import Alamofire

class importLibraries {
    static func connectionOfSeverForDataWith(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, success: @escaping (_ data: Data, _ code: Int?) -> Void, failure: @escaping (_ error: Error, _ code: Int?) -> ()) {
    
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                success(data, response.response?.statusCode)
            case .failure(let error):
                failure(error, response.response?.statusCode)
            }
        }
    }
    
    static func connectionOfServerForJSONWith(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, success: @escaping (_ data: Any, _ code: Int?) -> Void, failure: @escaping (_ error: Error, _ code: Int?) -> ()) {
        
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let any):
                success(any, response.response?.statusCode)
            case .failure(let error):
                failure(error, response.response?.statusCode)
            }
        }
    }
}
