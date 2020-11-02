//
//  RootInteractor.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 15..
//

import Foundation
import Combine
import MyProjectApi

final class RootInteractor: ServiceInteractor, InteractorInterface {

    weak var presenter: RootPresenterInteractorInterface!
}

extension RootInteractor: RootInteractorPresenterInterface {
    
    func list() -> AnyPublisher<RootEntity, Error> {
        self.services.api.getBlogPosts()
        .map { page -> RootEntity in
            let domain = "http://127.0.0.1:8080"
            return .init(items: page.items.map {
                .init(id: $0.id,
                      title: $0.title,
                      imageUrl: URL(string: domain + $0.image)!,
                      url: URL(string: domain + "/" + $0.slug)!)
                
            })
        }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
        
    }

}
