import Vapor

extension Environment {
    static let dbHost = Self.get("DB_HOST")!
    static let dbUser = Self.get("DB_USER")!
    static let dbPass = Self.get("DB_PASS")!
    static let dbName = Self.get("DB_NAME")!

    static let fsName = Self.get("FS_NAME")!
    static let fsRegion = Self.get("FS_REGION")!

    static let awsKey = Self.get("AWS_KEY")!
    static let awsSecret = Self.get("AWS_SECRET")!

    static let siwaId = Self.get("SIWA_ID")!
    static let siwaAppId = Self.get("SIWA_APP_ID")!
    static let siwaRedirectUrl = Self.get("SIWA_REDIRECT_URL")!
    static let siwaTeamId = Self.get("SIWA_TEAM_ID")!
    static let siwaJWKId = Self.get("SIWA_JWK_ID")!
    static let siwaKey = Self.get("SIWA_KEY")!.base64Decoded()!
    //...
    static let apnsKeyId = Self.get("APNS_KEY_ID")!
    static let apnsTeamId = Self.get("APNS_TEAM_ID")!
    static let apnsTopic = Self.get("APNS_TOPIC")!
    static let apnsKey = Self.get("APNS_KEY")!.base64Decoded()!
}
