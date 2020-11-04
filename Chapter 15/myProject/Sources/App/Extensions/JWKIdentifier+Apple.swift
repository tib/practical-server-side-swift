import Vapor
import JWT

extension JWKIdentifier {
    static let apple = JWKIdentifier(string: Environment.SignInWithApple.jwkId)
}
