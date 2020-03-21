//
//  FieldPasswordViewModel.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import RxCocoa

class FieldPasswordViewModel:BaseViewModel, FieldValidationType {

    // MARK: - Properties
    
    let maxLength: Int = FieldValidationConstants.Range.passwordMax
    
    var dataRelay: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    var errorRelay: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    
    // MARK: - Dealloc
    
    deinit {
//        print("deinit " + String(describing: self))
    }
    
    // MARK: - Public Methods
    
    func validate() -> Bool {
        
        let error: String?
        
        if !validateStringNotEmpty(with: dataRelay.value) {
            error = LocalizableService.shared.localizedText(with: "Validation_Empty")
        } else if !validateSize(with: dataRelay.value, size: (min: FieldValidationConstants.Range.passwordMin, max: FieldValidationConstants.Range.passwordMax)) {
            error = LocalizableService.shared.localizedText(with: "Validation_Password")
        } else {
            error = nil
        }
        
        errorRelay.accept(error)
        return error != nil ? false : true
    }
}

