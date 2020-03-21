//
//  BindableType.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit

enum ControlEventUseCase {
    case none
    case refresh
    case loadMore
}

protocol BindableType where Self: UIResponder {
    
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
    func bindControlEvent()
    func executeViewModelAction()
}

extension BindableType {
    
    func bindControlEvent() {
        
    }
    
    func executeViewModelAction() {
        
    }
}

extension BindableType where Self: BaseViewController {
    
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
        bindControlEvent()
        executeViewModelAction()
    }
}

extension BindableType where Self: UIView {
    
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
        bindControlEvent()
        executeViewModelAction()
    }
}

