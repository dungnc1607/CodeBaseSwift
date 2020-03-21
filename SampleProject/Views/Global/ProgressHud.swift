//
//  ProgressHud.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import PKHUD
import RxSwift

class ProgressHud: ReactiveCompatible {

    // MARK: - Properties
    
    public static let shared = ProgressHud.init()
    
    // MARK: - Dealloc
    
    deinit {
        
    }
    
    // MARK: - Initialization
    
    init() {
        HUD.allowsInteraction = false
    }
    
    // MARK: - Public Methods
    
    func show() {
        if let view = SceneCoordinator.shared.rootNavigationController?.view {
            HUD.show(HUDContentType.progress, onView: view)
        } else {
            HUD.show(HUDContentType.progress)
        }
    }
    
    func show(text: String) {
        guard let view = SceneCoordinator.shared.rootNavigationController?.view else { return }
        HUD.flash(HUDContentType.labeledError(title: nil, subtitle: text), onView: view, delay: Constants.Timer.flashDuration)
    }
    
    func showTextOnly(text: String, delay: Double = Constants.Timer.flashDuration, completion: ((Bool) -> Void)? = nil) {
        guard let view = SceneCoordinator.shared.rootNavigationController?.view else { return }
        HUD.flash(HUDContentType.label(text), onView: view, delay: delay)
    }
    
    func hide(animated: Bool = true) {
        HUD.hide(animated: animated)
    }
}
