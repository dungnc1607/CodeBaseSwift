//
//  LoginScene.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginScene: BaseViewController, BindableType {

    // MARK: - Properties
    
    var viewModel: LoginViewModel!
    
    fileprivate lazy var fieldEmailContainerView: TextFieldContainerView = {
        let fieldPhoneNumberContainerView = TextFieldContainerView.init(with: "Field_Email")
        return fieldPhoneNumberContainerView
    }()
    
    fileprivate lazy var fieldPasswordContainerView: TextFieldContainerView = {
        let fieldPasswordContainerView = TextFieldContainerView.init(with: "Field_Password")
        return fieldPasswordContainerView
    }()
    
    fileprivate lazy var buttonLogin: UIButton = {
        let buttonLogin = UIButton.init()
        buttonLogin.layer.cornerRadius = Constants.UI.cornerRadius
        buttonLogin.clipsToBounds = true
        buttonLogin.backgroundColor = Constants.Color.buttonColor
        buttonLogin.titleLabel?.font = Constants.Font.fontMediumBold
        return buttonLogin
    }()
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Override Methods
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(fieldEmailContainerView)
        view.addSubview(fieldPasswordContainerView)
        view.addSubview(buttonLogin)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        fieldEmailContainerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10 * Constants.UI.displayScale)
            make.leading.equalToSuperview().offset(20 * Constants.UI.displayScale)
            make.trailing.equalToSuperview().offset(-20 * Constants.UI.displayScale)
        }
        
        fieldPasswordContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(fieldEmailContainerView.snp.bottom).offset(10 * Constants.UI.displayScale)
            make.leading.equalToSuperview().offset(20 * Constants.UI.displayScale)
            make.trailing.equalToSuperview().offset(-20 * Constants.UI.displayScale)
        }
        
        buttonLogin.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(40 * Constants.UI.displayScale)
            make.width.equalTo(250 * Constants.UI.displayScale)
            make.top.equalTo(fieldPasswordContainerView.snp.bottom).offset(30 * Constants.UI.displayScale)
        }
    }
    
    override func driveUI() {
        super.driveUI()
        LocalizableService.shared.localizedText(with: "Login")
        .drive(onNext: { [unowned self] title in
            self.buttonLogin.setTitle(title.uppercased(), for: .normal)
        })
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - BindableType

extension LoginScene {
    
    func bindViewModel() {
        fieldEmailContainerView.bindViewModel(to: viewModel.fieldEmailViewModel)
        fieldPasswordContainerView.bindViewModel(to: viewModel.fieldPasswordViewModel)
        
        buttonLogin.rx.tap
        .filter({ [unowned self] in self.viewModel.validateForm()})
        .bind(to: viewModel.actionRequestUser.inputs)
        .disposed(by: rx.disposeBag)
        
        viewModel.errorRelay
        .asDriver(onErrorJustReturn: nil)
        .drive(onNext: { error in
            guard let error = error else { return }
            ProgressHud.shared.show(text: error)
        })
        .disposed(by: rx.disposeBag)
        
        viewModel.executing
        .asDriver(onErrorJustReturn: false)
        .drive(ProgressHud.shared.rx.isAnimating)
        .disposed(by: rx.disposeBag)
        
        viewModel.successRelay
        .asDriver(onErrorJustReturn: nil)
        .drive(onNext: { [unowned self] user in
            guard let user = user else { return }
            self.viewModel.onSuccessfullyLogin(with: user.name).execute()
        })
        .disposed(by: rx.disposeBag)
        
        viewModel.errorRelay
        .asDriver(onErrorJustReturn: nil)
        .drive(onNext: { error in
            guard let error = error else { return }
            ProgressHud.shared.show(text: error)
        })
        .disposed(by: rx.disposeBag)

    }
    
    func executeViewModelAction() {
        
    }

}
