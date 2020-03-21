//
//  BaseResponseModel.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation
import ObjectMapper

enum ResponseError : Int, Error {
    
    case noStatusCode       = 0
    case notModified        = 304
    case badRequest         = 400
    case unauthorized       = 401
    case accessDenied       = 403
    case notFound           = 404
    case methodNotAllowed   = 405
    case validate           = 422
    case serverError        = 500
    case badGateway         = 502
    case serviceUnavailable = 503
    case gatewayTimeout     = 504
    case noConnection       = -1009
    case timeOutError       = -1001
}

enum ResponseDataError: Error {
    
    case invalidResponseData(data: Any)
}

class BaseResponseModel<T: Mappable>: Mappable {
    
    // MARK: - Properties
    
    var data: T?
    var responseTime: Date?
    
    var isPlaceholderResponse: Bool {
        get {
            return responseTime == nil
        }
    }
    
    // MARK: - Initialization
    
    required convenience init?(map: Map) { self.init() }
    
    // MARK: - Mappable
    
    func mapping(map: Map) {
        data        <- map["data"]
        
        responseTime = Date.init()
    }
}

