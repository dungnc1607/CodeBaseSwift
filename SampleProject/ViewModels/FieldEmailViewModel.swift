//
//  FieldEmailViewModel.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import RxCocoa

class FieldEmailViewModel: BaseViewModel, FieldValidationType {

    // MARK: - Properties
    
    let maxLength: Int = FieldValidationConstants.Range.emailMax
    
    var dataRelay: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    var errorRelay: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    
    // MARK: - Public Methods
    
    func validate() -> Bool {
        
        let error: String?
        
        if !validateStringNotEmpty(with: dataRelay.value) {
            error = LocalizableService.shared.localizedText(with: "Validation_Empty")
        } else if !validateSize(with: dataRelay.value, size: (min: FieldValidationConstants.Range.defaultMin, max: FieldValidationConstants.Range.emailMax)) {
            error = "Range"
        } else if !validateString(with: dataRelay.value, pattern: FieldValidationConstants.Regex.REGEX_EMAIL) {
            error = "Wrong Email Format"
        } else {
            error = nil
        }
        
        errorRelay.accept(error)
        return error != nil ? false : true
    }
}
