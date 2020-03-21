//
//  FieldValidationType.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import RxCocoa

struct FieldValidationConstants {
    
    struct Regex {
        public static let REGEX_EMAIL = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        public static let REGEX_PASSWORD = "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&? ]).*$"
    }
    
    struct Range {
        
        public static let defaultMin = 1
        public static let defaultMax = 255
        public static let passwordMin = 8
        public static let passwordMax = 30
        public static let nameMax = defaultMax
        public static let emailMax = defaultMax
        public static let adressMax = defaultMax
    }
    
    struct Calendar {
        
        public static let minYear = 1900
        public static let dateFormat = "dd/MM/yyyy"
        public static let monthFormat = "MM"
        public static let yearFormat = "YYYY"
        
        public static func months() -> [String] {
            return (1...12).map { String($0) }
        }
        
        public static func years() -> [String] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = yearFormat
            let currentYear = Int(dateFormatter.string(from: Date.init()))
            return (minYear...currentYear!).map { String($0) }
        }
    }
    
    enum Gender: Int {
        case female = 0
        case male = 1
    }
}

protocol FieldValidationType {
    
    associatedtype ValueType
    var dataRelay: BehaviorRelay<ValueType> { get }
    var errorRelay: BehaviorRelay<String?> { get }
    
    func validate() -> Bool
}

extension FieldValidationType {
    
    func validateSize(with value: String, size: (min: Int, max: Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    func validateStringNotEmpty(with value: String) -> Bool {
        return value.count > 0
    }
    
    func validateStringIsNumber(with value: String) -> Bool {
        return Int(value) != nil
    }
    
    func validateString(with value: String, pattern: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
    
    func validateEqual<T: Equatable>(with value: T, confirmValue: T) -> Bool {
        return value == confirmValue
    }
}
