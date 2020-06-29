//
//  RootRouter.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 15..
//

import Foundation
import UIKit

final class RootRouter: ModuleRouter, RouterInterface {

    weak var presenter: RootPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension RootRouter: RootRouterPresenterInterface {

    func showAccount() {
        let viewController = self.modules.account()
        let navController = UINavigationController(rootViewController: viewController)
        self.viewController?.present(navController, animated: true)
    }
}
