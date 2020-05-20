//
//  AccountInteractor.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 20..
//

import Foundation
import Combine

final class AccountInteractor: ServiceInteractor, InteractorInterface {

    weak var presenter: AccountPresenterInteractorInterface!
}

extension AccountInteractor: AccountInteractorPresenterInterface {

    func signIn(token: String) -> AnyPublisher<String, Error> {
        self.services.api.siwa(token: token)
        .map { $0.value }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
}
