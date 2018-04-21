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
    static func connectionOfSeverForDataWith(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, success: @escaping (_ data: Data) -> Void, failure: @escaping (_ error: Error) -> ()) {
        
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    static func connectionOfServerForJSONWith(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, success: @escaping (_ data: Any) -> Void, failure: @escaping (_ error: Error) -> ()) {
        
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let any):
                success(any)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
