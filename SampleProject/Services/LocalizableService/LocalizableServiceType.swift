//
//  LocalizableServiceType.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation

protocol LocalizableServiceType where Self: LocalizableService {
    
    func getAvailableLanguages() -> [Language]
    func setCurrentLanguage(to language: Language)
}

