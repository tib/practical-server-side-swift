//
//  AccountRouter.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 20..
//

import Foundation
import UIKit

final class AccountRouter: RouterInterface {

    weak var presenter: AccountPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension AccountRouter: AccountRouterPresenterInterface {

    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
