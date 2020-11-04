//
//  AccountPresenter.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 20..
//

import Foundation
import Combine

final class AccountPresenter: PresenterInterface {

    var router: AccountRouterPresenterInterface!
    var interactor: AccountInteractorPresenterInterface!
    weak var view: AccountViewPresenterInterface!

    var operations: [String: AnyCancellable] = [:]
}

extension AccountPresenter: AccountPresenterRouterInterface {

}

extension AccountPresenter: AccountPresenterInteractorInterface {

}

extension AccountPresenter: AccountPresenterViewInterface {

    func start() {
        let token = UserDefaults.standard.string(forKey: "user-token")
        if token == nil {
            self.view.displayLogin()
        }
        else {
            self.view.displayLogout()
        }
    }

    func close() {
        self.router.dismiss()
    }

    func signIn(token: String) {
        self.operations["siwa"] = self.interactor.signIn(token: token)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
            self?.operations.removeValue(forKey: "siwa")
        }) { [weak self] token in
            UserDefaults.standard.set(token, forKey: "user-token")
            UserDefaults.standard.synchronize()
            self?.view.displayLogout()
        }
    }
    
    func logout() {
        UserDefaults.standard.set(nil, forKey: "user-token")
        UserDefaults.standard.synchronize()
        self.view.displayLogin()
    }

    func registerUserDevice(_ block: @escaping (() -> Void)) {
        guard
            let bearerToken = UserDefaults.standard.string(forKey: "user-token"),
            let deviceToken = UserDefaults.standard.string(forKey: "device-token")
        else {
            return
        }
        self.operations["device"] = self.interactor.register(deviceToken: deviceToken, bearerToken: bearerToken)
        .sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                print("Device registered.")
            case .failure(let error):
                print(error)
            }
            self?.operations.removeValue(forKey: "device")
            block()
        }) { _ in }
    }
}
