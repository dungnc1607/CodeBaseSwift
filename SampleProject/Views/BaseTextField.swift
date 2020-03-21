//
//  BaseTextField.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit
import RxCocoa
import NSObject_Rx

class BaseTextField: UITextField {

    // MARK: - Properties
    
    var maxLength: Int?
    
    override var text: String? {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Dealloc
    
    deinit {
//        print("deinit " + String(describing: self))
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        setupUI()
        setupConstraints()
        configureStream()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Override Methods
    
    func setupUI() {
        
        autocorrectionType = .no
        backgroundColor = UIColor.clear
        textColor = Constants.Color.textColor
        font = Constants.Font.fontSmall
    }
    
    func setupConstraints() {
        
    }
    
    func configureStream() {
        
    }
}

// MARK: - UITextFieldDelegate

extension BaseTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let maxLength = maxLength, let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= maxLength
    }
}

