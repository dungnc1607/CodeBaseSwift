//
//  BorderTextField.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit

class BorderTextField: BaseTextField {

    // MARK: - Properties
    
    let padding: UIEdgeInsets = UIEdgeInsets.init(top: Constants.UI.paddingThin,
                                                  left: Constants.UI.paddingThin,
                                                  bottom: Constants.UI.paddingThin,
                                                  right: Constants.UI.paddingThin)
    
    fileprivate lazy var innerShadow: CALayer = { [unowned self] in
        let innerShadow = CALayer.init()
        innerShadow.frame = self.bounds
        let shadowWidth = 1.2 * Constants.UI.displayScale
        let path = UIBezierPath(rect: innerShadow.bounds.inset(by: UIEdgeInsets.init(top: -shadowWidth,
                                                                                     left: -shadowWidth,
                                                                                     bottom: 0,
                                                                                     right: 0)))
        let cutout = UIBezierPath(rect: innerShadow.bounds).reversing()
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        innerShadow.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        innerShadow.shadowOffset = CGSize.zero
        innerShadow.shadowOpacity = 1
        innerShadow.shadowRadius = 3
        return innerShadow
        }()
    
    fileprivate lazy var buttonShowPassword: UIButton = {
        let buttonShowPassword = UIButton.init(type: .system)
        buttonShowPassword.backgroundColor = UIColor.clear
        buttonShowPassword.setTitleColor(Constants.Color.textLightColor, for: .normal)
        buttonShowPassword.titleLabel?.font = Constants.Font.fontTiny
        buttonShowPassword.titleLabel?.textAlignment = .center
        return buttonShowPassword
    }()
    
    override open var isSecureTextEntry: Bool {
        didSet {
            if isSecureTextEntry {
                configureButtonShowPassword()
            }
            buttonShowPassword.setTitle(LocalizableService.shared.localizedText(with: isSecureTextEntry ? "Show" : "Hide"), for: .normal)
        }
    }
    
    // MARK: - Dealloc
    
    deinit {
        print("deinit " + String(describing: self))
    }
    
    // MARK: - Private Methods
    
    fileprivate func configureButtonShowPassword() {
        
        guard isSecureTextEntry && buttonShowPassword.superview == nil else { return }
        
        buttonShowPassword.frame = CGRect.init(x: 0, y: 0, width: 55.0 * Constants.UI.displayScale, height: frame.size.height)
        rightView = buttonShowPassword
        rightViewMode = .always
    }
    
    // MARK: - Override Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.addSublayer(innerShadow)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        if let rightView = self.rightView {
            let rightFrame = rightView.frame
            return CGRect(x: bounds.width - rightFrame.size.width, y: 0, width: rightFrame.size.width, height: bounds.height)
        }
        return .zero
    }
    
    override func setupUI() {
        super.setupUI()
        
        backgroundColor = UIColor.white
        
        layer.borderColor = Constants.Color.borderColor.cgColor
        layer.borderWidth = Constants.UI.lineHeight
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        layer.cornerRadius = Constants.UI.cornerRadiusThin
        layer.masksToBounds = true
    }
    
    override func configureStream() {
        super.configureStream()
        
        buttonShowPassword.rx.tap
            .bind(to: rx.isSecureTextEntry)
            .disposed(by: rx.disposeBag)
    }
    
    // MARK: - public function
    
    public func removeShadow(size: CGFloat) {
        innerShadow.frame.size.width = size
    }


}
