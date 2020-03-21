//
//  SceneCoordinatorType.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import RxSwift

protocol SceneCoordinatorType {
    
    /// Transition to another scene
    @discardableResult func transition(to scene: Scene, type: SceneTransitionType, from: CATransitionSubtype?, animated: Bool) -> Completable
    
    /// Pop scene from navigation stack or dismiss current modal
    @discardableResult func pop(from: CATransitionSubtype?, animated: Bool) -> Completable
}

extension SceneCoordinatorType {
    
    @discardableResult func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
        return transition(to: scene, type: type, from: nil, animated: true)
    }
    
    @discardableResult func transition(to scene: Scene, type: SceneTransitionType, animated: Bool) -> Completable {
        return transition(to: scene, type: type, from: nil, animated: animated)
    }
    
    @discardableResult func transition(to scene: Scene, type: SceneTransitionType, from: CATransitionSubtype) -> Completable {
        return transition(to: scene, type: type, from: from, animated: true)
    }
    
    @discardableResult func pop() -> Completable {
        return pop(from: nil, animated: true)
    }
    
    @discardableResult func pop(from: CATransitionSubtype?) -> Completable {
        return pop(from: from, animated: true)
    }
}
