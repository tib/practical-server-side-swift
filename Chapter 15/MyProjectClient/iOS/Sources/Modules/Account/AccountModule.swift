//
//  AccountModule.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 20..
//
import Foundation
import UIKit

// MARK: - router

protocol AccountRouterPresenterInterface: RouterPresenterInterface {
    func dismiss()
}

// MARK: - presenter

protocol AccountPresenterRouterInterface: PresenterRouterInterface {

}

protocol AccountPresenterInteractorInterface: PresenterInteractorInterface {

}

protocol AccountPresenterViewInterface: PresenterViewInterface {
    func start()
    func close()
}

// MARK: - interactor

protocol AccountInteractorPresenterInterface: InteractorPresenterInterface {
    
}

// MARK: - view

protocol AccountViewPresenterInterface: ViewPresenterInterface {

}


// MARK: - module builder

final class AccountModule: ModuleInterface {

    typealias View = AccountView
    typealias Presenter = AccountPresenter
    typealias Router = AccountRouter
    typealias Interactor = AccountInteractor

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
