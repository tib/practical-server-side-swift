//
//  SceneDelegate.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder {
    
    var window: UIWindow?
}

extension SceneDelegate: UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        let rootView = App.shared.modules.root()
        let rootVC = UINavigationController(rootViewController: rootView)
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}

