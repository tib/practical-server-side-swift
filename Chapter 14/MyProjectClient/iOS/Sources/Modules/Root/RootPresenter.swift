//
//  RootPresenter.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 15..
//

import Foundation
import Combine

final class RootPresenter: PresenterInterface {

    var router: RootRouterPresenterInterface!
    var interactor: RootInteractorPresenterInterface!
    weak var view: RootViewPresenterInterface!

    var operations: [String: AnyCancellable] = [:]
}

extension RootPresenter: RootPresenterRouterInterface {

}

extension RootPresenter: RootPresenterInteractorInterface {

}

extension RootPresenter: RootPresenterViewInterface {

    func start() {
        self.reload()
    }
    
    func reload() {
        self.view.displayLoading()
        self.operations["posts"] = self.interactor.list()
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.view.display(error)
            }
            self?.operations.removeValue(forKey: "posts")
        }) { [weak self] entity in
            self?.view.display(entity)
        }
    }

    func account() {
        self.router.showAccount()
    }

}
