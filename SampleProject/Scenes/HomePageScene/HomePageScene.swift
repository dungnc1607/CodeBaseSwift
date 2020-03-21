//
//  HomePageScene.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomePageScene: BaseViewController, BindableType {

    // MARK: - Properties
    
    var viewModel: HomePageViewModel!
    
    fileprivate lazy var labelWelcome: UILabel = {
        let labelWelcome = UILabel.init()
        labelWelcome.font = Constants.Font.fontMedium
        labelWelcome.lineBreakMode = .byWordWrapping
        labelWelcome.numberOfLines = 0
        return labelWelcome
    }()
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Override Methods
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(labelWelcome)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        labelWelcome.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()

    }
    
    override func driveUI() {
        super.driveUI()
    }
}

// MARK: - BindableType

extension HomePageScene {
    
    func bindViewModel() {
        LocalizableService.shared.localizedText(with: "Welcome_Label")
        .drive(onNext: { [unowned self] text in
            self.labelWelcome.text = String.init(format: text, self.viewModel.name)
        })
        .disposed(by: rx.disposeBag)
    }
    
    func executeViewModelAction() {
        
    }

}
