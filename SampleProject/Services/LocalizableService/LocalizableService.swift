//
//  LocalizableService.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import RxCocoa

class LocalizableService: LocalizableServiceType {

    // MARK: - Properties
        
        public static let shared = LocalizableService.init()
        
        var currentLanguage: Language = .english
        
        fileprivate lazy var addressDictionary: NSDictionary = {
            guard let path = Bundle.main.path(forResource: "Address", ofType: "plist") else { return NSDictionary.init() }
            let addressDictionary = NSDictionary(contentsOfFile: path)
            return addressDictionary ?? NSDictionary.init()
        }()
        
        // MARK: - Dealloc
        
        deinit {
            
        }
        
        // MARK: - Public Methods
        
        func localizedText(with key: String) -> Driver<String> {
            return Localizer.shared.localized(key)
        }
        
        func localizedText(with key: String) -> String {
            return Localizer.shared.localized(key)
        }
        
        func localizedRegionArray() -> [[String: String]] {
            return addressDictionary["region"] as? [[String: String]] ?? []
        }
        
        func localizedDistrictArray(with key: String) -> [[String: String]] {
            guard let districts = addressDictionary["districts"] as? [String: Any] else { return [] }
            return districts[key] as? [[String: String]] ?? []
        }
    }

    // MARK: - LocalizableServiceType

    extension LocalizableService {
        
        func getCurrentLocale() -> Locale {
            return Locale.init(identifier: currentLanguage.rawValue)
        }
        
        func getCurrentLanguage() -> Language {
            return currentLanguage
        }
        
        func getAvailableLanguages() -> [Language] {
            return Language.allCases
        }
        
        func setCurrentLanguage(to language: Language) {
            currentLanguage = language
            Localizer.shared.changeLanguage.accept(language.rawValue)
        }
    }

