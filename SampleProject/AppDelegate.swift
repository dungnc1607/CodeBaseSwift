//
//  AppDelegate.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

#if swift(>=4.2)
    typealias ApplicationLaunchOptionsKey = UIApplication.LaunchOptionsKey
#else
    typealias ApplicationLaunchOptionsKey = UIApplicationLaunchOptionsKey
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SceneCoordinator.shared.window.makeKeyAndVisible()

        // Override point for customization after application launch.
        
        //Google map API Key
        GMSServices.provideAPIKey("AIzaSyAk6eIJgRky54WUEaCXifPYDkY1ISFEKdE")
        GMSPlacesClient.provideAPIKey("AIzaSyAk6eIJgRky54WUEaCXifPYDkY1ISFEKdE")
        
        let loginScene = Scene.loginScene(LoginViewModel.init())
        SceneCoordinator.shared.transition(to: loginScene, type: .root)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

