import Vapor

extension User.Token.Detail: Content {}

struct UserApiController {
    
    func signInApi(
        req: Request
    ) async throws -> User.Token.Detail {
        guard let user = req.auth.get(AuthenticatedUser.self) else {
            throw Abort(.unauthorized)
        }

        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789="
        let tokenValue = String((0..<64).map { _ in letters.randomElement()! })

        let token = UserTokenModel(
            value: tokenValue,
            userId: user.id
        )

        try await token.create(on: req.db)

        let account = User.Account.Detail(
            id: user.id,
            email: user.email
        )
        return .init(
            id: token.id!,
            value: token.value,
            user: account
        )
    }
}
