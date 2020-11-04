import Vapor
import Fluent

struct UserApiController {
    
    func login(req: Request) throws -> EventLoopFuture<UserTokenModel.GetContent> {
        guard let user = req.auth.get(UserModel.self) else {
            throw Abort(.unauthorized)
        }
        let tokenValue = [UInt8].random(count: 16).base64
        let token = UserTokenModel(value: tokenValue, userId: user.id!)
        return token.create(on: req.db).map { token.getContent }
    }
    
    func signInWithApple(req: Request) throws -> EventLoopFuture<UserTokenModel.GetContent> {
        struct AuthRequest: Content {
            enum CodingKeys: String, CodingKey {
                case idToken = "id_token"
            }
            let idToken: String
        }
        let auth = try req.content.decode(AuthRequest.self)
        
        return UserModel.siwa(req: req, idToken: auth.idToken, appId: Environment.SignInWithApple.id)
            .flatMap { user in
                UserTokenModel.create(on: req.db, for: user.id!).map { $0.getContent }
            }
    }
}
