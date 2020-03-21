//
//  BaseViewModel.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class BaseViewModel: NSObject {
    
    // MARK: - Properties
        
    var executing: Observable<Bool>!
    
    lazy var apiErrorRelay: BehaviorRelay<String?> = {
        let apiErrorRelay: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
        return apiErrorRelay
    }()
    
    lazy var databaseErrorRelay: BehaviorRelay<String?> = {
        let databaseErrorRelay: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
        return databaseErrorRelay
    }()
    
    // MARK: - Dealloc
    
    deinit {
    }
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        configureActions()
        configureActionsSuccess()
        configureActionsError()
        configureRelays()
    }
    
    // MARK: - Public Methods
    
    func onPressButtonBack() -> CocoaAction {
        return CocoaAction {
            SceneCoordinator.shared
                .pop()
                .asObservable()
                .map { _ in }
        }
    }
    
    func onPressButtonClose() -> CocoaAction {
        return CocoaAction {
            SceneCoordinator.shared
                .pop(from: .fromBottom)
                .asObservable()
                .map { _ in }
        }
    }
    
    // MARK: - Override Methods
    
    func configureActions() {
        
    }
    
    func configureActionsSuccess() {
        
    }
    
    func configureActionsError() {
        
    }
    
    func configureRelays() {
        
    }
}
