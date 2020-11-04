import Vapor

extension Environment {

    struct SignInWithApple {
        /// com.example.siwa.service
        static let id = Environment.get("SIWA_ID")!
        /// https://example.com/siwa-redirect
        static let redirectUrl = Environment.get("SIWA_REDIRECT_URL")!
        /// XXXXXXXXXX
        static let jwkId = Environment.get("SIWA_JWK_ID")!
        /// https://en.wikipedia.org/wiki/Base64
        static let privateKey = Environment.get("SIWA_PRIVATE_KEY")!.base64Decoded()!
        /// XXXXXXXXXX
        static let teamId = Environment.get("SIWA_TEAM_ID")!
        /// com.example.ios.app
        static let appBundleId = Environment.get("SIWA_APP_BUNDLE_ID")!
    }
}
