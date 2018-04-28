//
//  importLibraries.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 21..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import Foundation
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit

// MARK: - Classes
class ImportedLibraries {
    // -----------------------------> Alamofire
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
    
    static func uploadOntoServer(multipartFormData: @ escaping (MultipartFormData) -> Void, usingThreshold: UInt64, to: URLConvertible, method: HTTPMethod, headers: HTTPHeaders?, encodingFailure: @escaping (_ error: Error) -> (), success: @escaping (_ data: Data, _ code: Int?) -> Void, failure: @escaping (_ error: Error, _ code: Int?) -> Void) {
        
        Alamofire.upload(multipartFormData: multipartFormData, usingThreshold: usingThreshold, to: to, method: method, headers: headers, encodingCompletion: { (result) in
            switch result {
            case .success(let request, _, _):
                request.responseData(completionHandler: { (response) in
                    switch response.result {
                    case .success(let data):
                        success(data, response.response?.statusCode)
                    case.failure(let error):
                        failure(error, response.response?.statusCode)
                    }
                })
            case .failure(let error):
                encodingFailure(error)
            }
        })
    }
    
    // -----------------------------> Facebook
    
    static func FacebookAppDelegateShareInstance(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    static func FacebookAppDelegateShareInstance(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }
    
    class FacebookLogInButton: FBSDKLoginButton {
        
    }
    
    class FacebookLogInManager: FBSDKLoginManager {
        
    }
    
    class FacebooLogInManagerResult: FBSDKLoginManagerLoginResult {
        
    }
    
    static func FacebookAccessTokenString() -> String! {
        return FBSDKAccessToken.current().tokenString
    }
    
    static func FacebookAccessToken() -> FBSDKAccessToken! {
        return FBSDKAccessToken.current()
    }
}

// MARK: - Protocols
// -----------------------------> Facebook
protocol FacebookLogInBtnDelegate: FBSDKLoginButtonDelegate {
    
}
