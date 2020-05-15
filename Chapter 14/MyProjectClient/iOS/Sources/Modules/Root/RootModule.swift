//
//  RootModule.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 15..
//
import Foundation
import UIKit

// MARK: - router

protocol RootRouterPresenterInterface: RouterPresenterInterface {

}

// MARK: - presenter

protocol RootPresenterRouterInterface: PresenterRouterInterface {

}

protocol RootPresenterInteractorInterface: PresenterInteractorInterface {

}

protocol RootPresenterViewInterface: PresenterViewInterface {
    func start()
}

// MARK: - interactor

protocol RootInteractorPresenterInterface: InteractorPresenterInterface {

}

// MARK: - view

protocol RootViewPresenterInterface: ViewPresenterInterface {

}


// MARK: - module builder

final class RootModule: ModuleInterface {

    typealias View = RootView
    typealias Presenter = RootPresenter
    typealias Router = RootRouter
    typealias Interactor = RootInteractor

    func build() -> UIViewController {
        let view = View()
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view

        return view
    }
}
