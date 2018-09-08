//
//  APIManager.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import UIKit

enum APIError:Error {
    case networkError
}

enum HTTPMethod: String {
    case post = "POST"
}

typealias Parameters = [String:Any]
typealias HTTPHeaders = [String:String]

class APIManager {
    static let sharedManager = APIManager()

    func loginWithEmail(_ email:String?, _ password:String?) {
        
        let params = [
            "email": email ?? "",
            "password": password ?? "",
            ]
        
        let headers = ["Content-Type": "application/json"]
        
        if let url = URL(string: "\(Host.apiBaseUrl)/api/login?delay=5") {
            self.request(url: url, method: .post, parameters: params, headers: headers, completionBlock: {
                data in
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] ?? [:], let token = json["token"] as? String {
                    SessionManager.sharedManager.accessToken = token
                    SessionManager.sharedManager.isAuthenticated = true
                }
            })
        }
    }
    
    private func request(url:URL, method:HTTPMethod, parameters:Parameters?, headers: HTTPHeaders?, completionBlock: @escaping (Data) -> Void) {
        
        var request:URLRequest = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        if method == HTTPMethod.post {
            let json = try? JSONSerialization.data(withJSONObject: parameters ?? [], options: [])
            request.httpBody = json
        }
        
        OperationQueue.main.addOperation() {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            OperationQueue.main.addOperation() {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }

            if error == nil, let result = data {
                completionBlock(result)
            }else{
                //error handling
            }
        }
        task.resume()
    }
}
