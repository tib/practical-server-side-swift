import Vapor
import Fluent

struct UserApiController {
    
    func login(req: Request) throws -> EventLoopFuture<UserTokenModel.GetContent> {
        guard let user = req.auth.get(UserModel.self) else {
            throw Abort(.unauthorized)
        }
        return UserTokenModel.create(on: req.db, for: user.id!).map { $0.getContent }
    }

    func signInWithApple(req: Request) throws -> EventLoopFuture<UserTokenModel.GetContent> {
        struct AuthRequest: Content {
            enum CodingKeys: String, CodingKey {
                case idToken = "id_token"
            }
            let idToken: String
        }
        let auth = try req.content.decode(AuthRequest.self)

        return UserModel.siwa(req: req, idToken: auth.idToken, appId: Environment.siwaAppId)
        .flatMap { user in
            UserTokenModel.create(on: req.db, for: user.id!).map { $0.getContent }
        }
    }
    
    func registerDevice(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let user = req.auth.get(UserModel.self) else {
            throw Abort(.unauthorized)
        }
        struct Input: Decodable {
            let token: String
        }
        let input = try req.content.decode(Input.self)
        return UserDeviceModel(token: input.token, userId: user.id!)
            .create(on: req.db)
            .transform(to: HTTPStatus.ok)
    }
}
