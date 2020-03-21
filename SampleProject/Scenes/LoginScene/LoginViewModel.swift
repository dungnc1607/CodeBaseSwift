//
//  LoginViewModel.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class LoginViewModel: BaseViewModel {
    //MARK: - Properties
    
    var successRelay: PublishRelay<User?> = PublishRelay.init()
    var errorRelay: PublishRelay<String?> = PublishRelay.init()
    
    let fieldEmailViewModel: FieldEmailViewModel = FieldEmailViewModel.init()
    let fieldPasswordViewModel: FieldPasswordViewModel = FieldPasswordViewModel.init()
    
    private(set) var actionRequestUser: Action<Void, BaseResponseModel<User>>!
    
    //MARK: - Override functions
    
    override func configureActions() {
        super.configureActions()
        
        actionRequestUser = Action {
            APIUserService.shared.fetchUser()
        }
    }
    
    override func configureActionsSuccess() {
        super.configureActionsSuccess()
        
        actionRequestUser
        .elements
        .map({ $0.data })
        .bind(to: successRelay)
        .disposed(by: rx.disposeBag)
    }
    
    override func configureActionsError() {
        super.configureActionsError()
        
        actionRequestUser
        .errors
        .filter({ if case .underlyingError(_) = $0 { return true } else { return false } })
        .map({ error -> String? in
            guard case .underlyingError(let error) = error else { return nil }
            return error.localizedDescription
        })
        .bind(to: apiErrorRelay)
        .disposed(by: rx.disposeBag)
    }
    
    override func configureRelays() {
        super.configureRelays()
        
        executing = Observable.merge(actionRequestUser.executing)
        
        Observable.merge(fieldEmailViewModel.errorRelay.asObservable(),
                         fieldPasswordViewModel.errorRelay.asObservable())
        .bind(to: errorRelay)
        .disposed(by: rx.disposeBag)
    }
    
    //MARK: Private function
    
    func onSuccessfullyLogin(with name: String) -> CocoaAction {
        return CocoaAction {
            let googleMapScene = Scene.googleMapScene(GoogleMapViewModel.init())
            return SceneCoordinator.shared
                .transition(to: googleMapScene, type: .push)
                .asObservable()
                .map { _ in }
        }
    }
}

// MARK: - ViewModelValidationType

extension LoginViewModel {
    
    func validateForm() -> Bool {
        
        return fieldEmailViewModel.validate() &&
                fieldPasswordViewModel.validate()
        
    }
}
