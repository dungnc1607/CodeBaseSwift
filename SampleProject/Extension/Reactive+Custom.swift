//
//  Reactive+Custom.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    
    var isSecureTextEntry: Binder<()> {
        return Binder(base, binding: { (textField, _) in
            textField.isSecureTextEntry = !textField.isSecureTextEntry
                if let text = textField.text {
                    textField.text?.removeAll()
                    textField.insertText(text)
                }
        })
    }
}

extension Reactive where Base: ProgressHud {

    var isAnimating: Binder<Bool> {
        return Binder(base) { (progressHud, isVisible) in
            if isVisible {
                progressHud.show()
            } else {
                progressHud.hide(animated: true)
            }
        }
    }
}

