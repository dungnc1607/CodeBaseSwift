//
//  SceneCoordinator.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {
    // MARK: - Properties
        
    public static let shared = SceneCoordinator.init()
    
    public lazy var window: UIWindow = {
        let window = UIWindow.init(frame: Constants.UI.screenBounds)
        window.backgroundColor = Constants.Color.backgroundColor
        return window
    }()
    
    public var navigationBarHeight: CGFloat {
        guard let rootNavigationController = rootNavigationController else { return 0 }
        return rootNavigationController.navigationBar.frame.size.height
    }
    
    public var isInLuckyDraw: Bool = false
    
    fileprivate(set) weak var rootNavigationController: BaseNavigationController?
    fileprivate(set) weak var currentScene: UIViewController?
    
    lazy var loginScene: LoginScene = { [unowned self] in
        let loginScene = Scene.loginScene(LoginViewModel.init()).viewController() as! LoginScene
        return loginScene
    }()
    
    // MARK: - Dealloc
    
    deinit {
        
    }
    
    // MARK: - Private Methods
    
    fileprivate static func actualScene(for viewController: UIViewController?) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first
        } else {
            return viewController
        }
    }
}

// MARK: - SceneCoordinatorType

extension SceneCoordinator {
    
    @discardableResult func transition(to scene: Scene, type: SceneTransitionType, from: CATransitionSubtype?, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        let viewController = scene.viewController()
        switch type {
            case .root:
                let completion = { [weak self] in
                    self?.rootNavigationController = viewController as? BaseNavigationController
                    self?.window.rootViewController = viewController
                    self?.currentScene = SceneCoordinator.actualScene(for: viewController)
                    subject.onCompleted()
                }
                completion()
            case .push:
                guard let navigationController = currentScene?.navigationController else {
                    
                    fatalError("Can't push a view controller without a current navigation controller")
                }
                
                // One-off subscription to be notified when push complete
                _ = navigationController.rx.delegate
                    .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                    .map { _ in }
                    .bind(to: subject)
                (navigationController as? BaseNavigationController)?.pushViewControllerWithTransition(from: from, viewController: viewController, animated: animated)
                currentScene = SceneCoordinator.actualScene(for: viewController)

            case .modal:
                currentScene?.present(viewController, animated: animated) {
                    subject.onCompleted()
                }
                currentScene = SceneCoordinator.actualScene(for: viewController)
            
            case .replace:
                guard let navigationController = currentScene?.navigationController else {
                    fatalError("Can't push a view controller without a current navigation controller")
                }
                navigationController.replaceTopViewController(with: viewController, animated: false)
                currentScene = SceneCoordinator.actualScene(for: viewController)
            
        }
        return subject.asObservable()
                .take(1)
                .ignoreElements()
        
        }
    
    @discardableResult func pop(from: CATransitionSubtype?, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        if let presenter = currentScene?.presentingViewController {
            // Dismiss a modal controller
            currentScene?.dismiss(animated: animated) {
                self.currentScene = SceneCoordinator.actualScene(for: presenter)
                subject.onCompleted()
            }
        } else if let navigationController = currentScene?.navigationController {
            // Navigate up the stack
            // One-off subscription to be notified when pop complete
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
//            navigationController.popViewController(animated: animated)
            (navigationController as? BaseNavigationController)?.popViewControllerWithTransition(from: from, animated: animated)
            currentScene = SceneCoordinator.actualScene(for: navigationController.viewControllers.last)
        }
        return subject.asObservable()
                .take(1)
                .ignoreElements()
    }
}

extension UINavigationController {
    func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
        var vcs = viewControllers
        vcs[vcs.count - 1] = viewController
        setViewControllers(vcs, animated: animated)
    }
}
