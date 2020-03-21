//
//  BaseRequestModel.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation
import Alamofire

struct RequestHeader {
    
    static let json: [String: String] = [
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json"
    ]
}

class BaseRequestModel {

    // MARK: - Properties
    
    var endpoint: String!
    var parameters: [String: Any] = [:]
    
    let httpMethod: HTTPMethod
    let headers: [String: String]
    let shouldRequireAccessToken: Bool
    let shouldCacheResponse: Bool
    
    var encoding: ParameterEncoding {
        get {
            return httpMethod == .get ? URLEncoding.default : JSONEncoding.default
        }
    }
    
    // MARK: - Dealloc
    
    deinit {
        
    }
    
    // MARK: - Initialization
    
    init(httpMethod: HTTPMethod = .get,
         headers: [String: String] = RequestHeader.json,
         shouldRequireAccessToken: Bool = true,
         shouldCacheResponse: Bool = true) {
        
        self.httpMethod = httpMethod
        self.headers = headers
        self.shouldRequireAccessToken = shouldRequireAccessToken
        self.shouldCacheResponse = shouldCacheResponse
    }
}
