import Vapor
import Fluent
import JWT

extension UserModel {

    static func siwa(req: Request, idToken: String, appId: String) -> EventLoopFuture<UserModel> {
        req.jwt.apple.verify(idToken, applicationIdentifier: appId)
        .flatMap { identityToken -> EventLoopFuture<UserModel> in
            guard let email = identityToken.email else {
                return req.eventLoop.future(error: Abort(.unauthorized))
            }
            return UserModel.query(on: req.db)
                .group(.or) { $0
                    .filter(\.$appleId == identityToken.subject.value)
                    .filter(\.$email == email)
            }
            .first()
            .map { user -> UserModel in
                guard let user = user else {
                    return UserModel(email: email,
                                     password: UUID().uuidString,
                                     appleId: identityToken.subject.value)
                }
                return user
            }
        }
        .flatMap { user in
            user.save(on: req.db).map { user }
        }
    }
}
