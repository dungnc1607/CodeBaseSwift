//
//  BaseNavigationController.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit
import SnapKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // MARK: - Properties
        
    fileprivate var shouldIgnorePushScene: Bool = false
    
    fileprivate var navigationBarTheme: Constants.Theme.NavigationTheme = .transparent {
        didSet {
            iconHomeContainerView.isHidden = !(navigationBarTheme == .colored)
        }
    }
    
    fileprivate lazy var iconHomeContainerView: UIView = { [unowned self] in
        let iconHomeContainerView = UIView.init()
        iconHomeContainerView.backgroundColor = UIColor.clear
        iconHomeContainerView.clipsToBounds = true
        iconHomeContainerView.isHidden = true
        iconHomeContainerView.isUserInteractionEnabled = false
        iconHomeContainerView.addSubview(self.iconHomeImageView)
        return iconHomeContainerView
        }()
    
    fileprivate lazy var iconHomeImageView: UIImageView = {
        let iconHomeImageView = UIImageView.init()
        iconHomeImageView.backgroundColor = UIColor.clear
        iconHomeImageView.contentMode = .scaleAspectFit
        iconHomeImageView.image = UIImage.init(named: Constants.ImageName.iconHome)
        iconHomeImageView.isUserInteractionEnabled = false
        return iconHomeImageView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch navigationBarTheme {
        case .transparent:
            return .default
            
        case .colored:
            return .lightContent
            
        case .transparentColored:
            return .default
            
        case .transparentOpacity:
            return .default
        }
    }
    
    // MARK: - Dealloc
    
    deinit {
        print("deinit " + String(describing: self))
    }
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupConstraints()
        configureStream()
    }
    
    // MARK: - Public Method
    
    public func configureNavigationBar(with navigationBarTheme: Constants.Theme.NavigationTheme) {
        self.navigationBarTheme = navigationBarTheme
        switch navigationBarTheme {
        case .transparent:
            navigationBar.isTranslucent = true
            navigationBar.setBackgroundImage(UIImage.init(),
                                             for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            navigationBar.barTintColor = UIColor.clear
            navigationBar.tintColor = Constants.Color.blackColor
            
        case .colored:
            navigationBar.isTranslucent = false
            navigationBar.setBackgroundImage(UIImage.init(named: Constants.ImageName.navigation)?.resizableImage(withCapInsets: .zero, resizingMode: .stretch),
                                             for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            navigationBar.barTintColor = Constants.Color.appColor
            navigationBar.tintColor = UIColor.white
            
        case .transparentColored:
            navigationBar.isTranslucent = true
            navigationBar.setBackgroundImage(UIImage.init(),
                                             for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            navigationBar.barTintColor = UIColor.clear
            navigationBar.tintColor = UIColor.white
            
        case .transparentOpacity:
            navigationBar.isTranslucent = true
            navigationBar.setBackgroundImage(UIImage.init(named: Constants.ImageName.storeNavigation)?.resizableImage(withCapInsets: .zero, resizingMode: .stretch),
                                             for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            navigationBar.backgroundColor = .clear
            navigationBar.barTintColor = .clear
            navigationBar.tintColor = UIColor.white
        }
        navigationBar.titleTextAttributes = getTitleTextAttributes()
    }
    
    public func getTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        switch navigationBarTheme {
        case .transparent:
            return [NSAttributedString.Key.foregroundColor: Constants.Color.blackColor, NSAttributedString.Key.font: Constants.Font.fontBold]
            
        case .colored:
            return [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: Constants.Font.fontBold]
            
        case .transparentColored:
            return [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: Constants.Font.fontBold]
            
        case .transparentOpacity:
            return [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: Constants.Font.fontBold]
        }
    }
    
    public func pushViewControllerWithTransition(from: CATransitionSubtype? = nil,
                                                 viewController: UIViewController,
                                                 animated: Bool = true,
                                                 duration: Double = Constants.Timer.animationDuration) {
        if !shouldIgnorePushScene {
            shouldIgnorePushScene = true
            if from == nil {
                super.pushViewController(viewController, animated: animated)
            } else {
                let transition = CATransition()
                transition.duration = duration
                transition.type = CATransitionType.moveIn
                transition.subtype = from
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                super.view.layer.add(transition, forKey: kCATransition)
                super.pushViewController(viewController, animated: false)
            }
        }
    }
    
    public func popViewControllerWithTransition(from: CATransitionSubtype? = nil,
                                                animated: Bool = true,
                                                duration: Double = Constants.Timer.animationDuration) {
        if from == nil {
            super.popViewController(animated: animated)
        } else {
            let transition = CATransition()
            transition.duration = duration
            transition.type = CATransitionType.reveal
            transition.subtype = from
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            super.view.layer.add(transition, forKey: kCATransition)
            super.popViewController(animated: false)
        }
    }
    
    // MARK: - Private Methods
    
    fileprivate func setupUI() {
        setNeedsStatusBarAppearanceUpdate()
        
        delegate = self
        
        view.autoresizingMask = []
        view.autoresizesSubviews = false
        view.isOpaque = false
        
        navigationBar.shadowImage = UIImage.init()
        navigationBar.addSubview(iconHomeContainerView)
        configureNavigationBar(with: navigationBarTheme)
    }
    
    fileprivate func setupConstraints() {
        iconHomeContainerView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-Constants.UI.padding)
            make.bottom.equalToSuperview()
        }
        
        iconHomeImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(12.0 * Constants.UI.displayScale)
        }
    }
    
    fileprivate func configureStream() {
        rx.didShow
            .subscribe(onNext: { [unowned self] _ in
                self.shouldIgnorePushScene = false
            })
            .disposed(by: rx.disposeBag)
    }
    
    // MARK: - Override Method
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.pushViewControllerWithTransition(from: nil, viewController: viewController, animated: animated)
    }
}

//// MARK: - UINavigationControllerDelegate
//
//extension BaseNavigationController {
//    
//    func navigationController(_ navigationController: UINavigationController,
//                              animationControllerFor operation: UINavigationController.Operation,
//                              from fromVC: UIViewController,
//                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//        if let sourceTransition = fromVC as? (RMPZoomTransitionAnimating & RMPZoomTransitionDelegate),
//            let destinationTransition = toVC as? (RMPZoomTransitionAnimating & RMPZoomTransitionDelegate) {
//            let animator = RMPZoomTransitionAnimator.init()
//            animator.goingForward = operation == .push || operation == .pop
//            animator.sourceTransition = sourceTransition
//            animator.destinationTransition = destinationTransition
//            return animator
//        } else { return nil }
//    }
//}
