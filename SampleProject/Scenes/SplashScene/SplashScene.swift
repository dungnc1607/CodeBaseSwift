//
//  SplashScene.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit

final class SplashScene: BaseViewController, BindableType {

    // MARK: - Properties
    
    var viewModel: SplashViewModel!
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

// MARK: - BindableType

extension SplashScene {
    
    func bindViewModel() {
        
    }
    
    func executeViewModelAction() {
        
    }

}
