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
    
    struct Apns {
        /// XXXXXXXXXX
        static let keyId = Environment.get("APNS_KEY_ID")!
        /// https://en.wikipedia.org/wiki/Base64
        static let privateKey = Environment.get("APNS_PRIVATE_KEY")!.base64Decoded()!
        /// XXXXXXXXXX
        static let teamId = Environment.get("APNS_TEAM_ID")!
        /// com.example.ios.app
        static let topic = Environment.get("APNS_TOPIC")!
    }

    struct Postgres {
        /// postgres://myuser:mypass@localhost:5432/mydb
        //static let connectionUrl = Environment.get("PSQL_CONNECTION_URL")!

        static let host = Environment.get("DB_HOST")!
        static let port = Int(Environment.get("DB_PORT")!)!
        static let user = Environment.get("DB_USER")!
        static let pass = Environment.get("DB_PASS")!
        static let database = Environment.get("DB_NAME")!
    }

    struct Aws {
        static let region = Environment.get("AWS_REGION")!
        static let bucket = Environment.get("AWS_BUCKET")!
    }
}
