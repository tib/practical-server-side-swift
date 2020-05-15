//
//  RootInteractor.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 15..
//

import Foundation

final class RootInteractor: InteractorInterface {

    weak var presenter: RootPresenterInteractorInterface!
}

extension RootInteractor: RootInteractorPresenterInterface {

}
