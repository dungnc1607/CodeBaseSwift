//
//  APIEndpoints.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation

public struct APIEndpoints {
    
    public static let baseUrl = "https://reqres.in/api/"
    
    public struct User {
        public static let getUser = baseUrl + "users/2"
    }
}
