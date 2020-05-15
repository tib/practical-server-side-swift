//
//  RootRouter.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 15..
//

import Foundation
import UIKit

final class RootRouter: RouterInterface {

    weak var presenter: RootPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension RootRouter: RootRouterPresenterInterface {

}