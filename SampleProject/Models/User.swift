//
//  User.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import RxDataSources

final class User: Object, Mappable {
    
    // MARK: - Properties
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var mobile: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var gender: Int = 0
    @objc dynamic var monthOfBirth: Int = 0
    @objc dynamic var yearOfBirth: Int = 0
    @objc dynamic var address: String = ""
    
    public var name: String {
        get {
            return firstName + " " + lastName
        }
    }
    
    public var genderKey: String {
        get {
            if gender == FieldValidationConstants.Gender.female.rawValue {
                return "Female"
            }
            else if gender == FieldValidationConstants.Gender.male.rawValue {
                return "Male"
            }
            else {
                return ""
            }
        }
    }
    
    public var birthString: String {
        get {
            return String(monthOfBirth) + "/" + String(yearOfBirth)
        }
    }
    
    // MARK: - Initialization
    
    required convenience init?(map: Map) { self.init() }
    
    // MARK: - Override Methods
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Mappable

extension User {
    
    func mapping(map: Map) {
        id        <- map["id"]
        firstName <- map["first_name"]
        lastName  <- map["last_name"]
        avatar    <- map["avatar"]
    }
}

// MARK: - IdentifiableType

extension User: IdentifiableType {
    
    var identity: Int {
        return self.isInvalidated ? 0 : id
    }
}
