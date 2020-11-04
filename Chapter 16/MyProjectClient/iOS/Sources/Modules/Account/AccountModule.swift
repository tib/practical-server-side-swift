//
//  AccountModule.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 20..
//
import Foundation
import UIKit
import Combine

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
    func signIn(token: String)
    func logout()
    func registerUserDevice(_ block: @escaping (() -> Void))
}

// MARK: - interactor

protocol AccountInteractorPresenterInterface: InteractorPresenterInterface {
    func signIn(token: String) -> AnyPublisher<String, Error>
    func register(deviceToken: String, bearerToken: String) -> AnyPublisher<Void, Error>
}

// MARK: - view

protocol AccountViewPresenterInterface: ViewPresenterInterface {
    func displayLogin()
    func displayLogout()
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
