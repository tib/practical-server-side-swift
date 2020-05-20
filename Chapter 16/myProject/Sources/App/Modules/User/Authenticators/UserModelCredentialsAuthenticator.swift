import Vapor
import Fluent

struct UserModelCredentialsAuthenticator: CredentialsAuthenticator {
    
    struct Input: Content {
        let email: String
        let password: String
    }

    typealias Credentials = Input

    func authenticate(credentials: Credentials,
                      for req: Request) -> EventLoopFuture<Void> {
        UserModel.query(on: req.db)
            .filter(\.$email == credentials.email)
            .first()
            .map {
                do {
                    if
                        let user = $0,
                        try Bcrypt.verify(credentials.password,
                                          created: user.password)
                    {
                        req.auth.login(user)
                    }
                }
                catch {
                    // do nothing...
                }
            }
    }
}
