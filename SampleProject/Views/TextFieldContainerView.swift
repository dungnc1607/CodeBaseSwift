//
//  TextFieldContainerView.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit

class TextFieldContainerView: BaseFieldContainerView {
    // MARK: - Properties
        
    // Should be BorderTextField
    var textField: BaseTextField {
        return contentView as! BaseTextField
    }
    
    // MARK: - Dealloc
    
    deinit {
        
    }
    
    // MARK: - Initialization
    
    required init(with titleKey: String? = nil, shouldShowTitle: Bool = true, isRequired: Bool = false) {
        let textField = BorderTextField.init()
        super.init(with: textField, titleKey: titleKey, shouldShowTitle: shouldShowTitle, isRequired: isRequired)
    }
    
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Public Methods
    
    func configureValue(with text: String) {
        textField.text = text
    }
    
    func getValue() -> String? {
        return textField.text
    }
    
    // MARK: - Override Methods
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        if contentView as? BorderTextField != nil {
            textField.snp.makeConstraints { (make) in
                make.height.equalTo(Constants.UI.textFieldHeight)
            }
        }
    }
    
    override func setupCornerRadius() {
        super.setupCornerRadius()
        
    }
    
    override func setupGestures() {
        super.setupGestures()
        
    }
    
    override func driveUI() {
        super.driveUI()
        
    }
    
    override func configureStream() {
        super.configureStream()
        
    }
    
    override func handleCleanUp() {
        super.handleCleanUp()
        
    }
    
    // MARK: - BindableType
    
    override func bindViewModel() {
        super.bindViewModel()
        
        switch viewModel {
            
        case is FieldPasswordViewModel:
            let fieldPasswordViewModel: FieldPasswordViewModel = viewModel as! FieldPasswordViewModel
            textField.isSecureTextEntry = true
            textField.maxLength = fieldPasswordViewModel.maxLength
            textField.rx.text.orEmpty
                .bind(to: fieldPasswordViewModel.dataRelay)
                .disposed(by: rx.disposeBag)
            
        case is FieldEmailViewModel:
            let fieldEmailViewModel: FieldEmailViewModel = viewModel as! FieldEmailViewModel
            textField.keyboardType = .emailAddress
            textField.maxLength = fieldEmailViewModel.maxLength
            textField.rx.text.orEmpty
                .bind(to: fieldEmailViewModel.dataRelay)
                .disposed(by: rx.disposeBag)
            
        default:
            fatalError("Bind to wrong FieldContainerView")
        }
    }
    
    override func executeViewModelAction() {
        super.executeViewModelAction()
        
    }
}
