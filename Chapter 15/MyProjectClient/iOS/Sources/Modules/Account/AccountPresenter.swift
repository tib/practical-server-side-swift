//
//  AccountPresenter.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 20..
//

import Foundation

final class AccountPresenter: PresenterInterface {

    var router: AccountRouterPresenterInterface!
    var interactor: AccountInteractorPresenterInterface!
    weak var view: AccountViewPresenterInterface!

}

extension AccountPresenter: AccountPresenterRouterInterface {

}

extension AccountPresenter: AccountPresenterInteractorInterface {

}

extension AccountPresenter: AccountPresenterViewInterface {

    func start() {

    }
    
    func close() {
        self.router.dismiss()
    }

}
