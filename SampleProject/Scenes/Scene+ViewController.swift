//
//  Scene+ViewController.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .splashScene(let viewModel):
            let splashScene = SplashScene.init()
            splashScene.bindViewModel(to: viewModel)
            let rootNavigationController: BaseNavigationController
            if Constants.UI.getSafeAreaTopPadding() == 0 {
                // Case iPhone not contain notch
                rootNavigationController = BaseNavigationController.init(navigationBarClass: BaseNavigationBar.self, toolbarClass: nil)
                rootNavigationController.viewControllers = [splashScene]
            } else {
            rootNavigationController = BaseNavigationController.init(rootViewController: splashScene)
            }
            return rootNavigationController
        
        case .loginScene(let viewModel):
            let loginScene = LoginScene.init()
            loginScene.bindViewModel(to: viewModel)
            let rootNavigationController: BaseNavigationController
        if Constants.UI.getSafeAreaTopPadding() == 0 {
                // Case iPhone not contain notch
                rootNavigationController = BaseNavigationController.init(navigationBarClass: BaseNavigationBar.self, toolbarClass: nil)
                rootNavigationController.viewControllers = [loginScene]
        } else {
                rootNavigationController = BaseNavigationController.init(rootViewController: loginScene)
            }
        return rootNavigationController
        
            
        case .homepageScene(let viewModel):
            let homePageScene = HomePageScene.init()
        homePageScene.bindViewModel(to: viewModel)
        let rootNavigationController = BaseNavigationController.init(rootViewController: homePageScene)
        return rootNavigationController
            
        case .googleMapScene(let viewModel):
            let googleMapScene = GoogleMapScene.init()
        googleMapScene.bindViewModel(to: viewModel)
        return googleMapScene
            
        }
    }
}

