//
//  AccountInteractor.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 20..
//

import Foundation

final class AccountInteractor: InteractorInterface {

    weak var presenter: AccountPresenterInteractorInterface!
}

extension AccountInteractor: AccountInteractorPresenterInterface {

}
