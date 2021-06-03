import Foundation
import Vapor

public struct ValidationError: Codable {

    public let message: String?
    public let details: [ValidationErrorDetail]
    
    public init(message: String?, details: [ValidationErrorDetail]) {
        self.message = message
        self.details = details
    }
}

extension ValidationError: Content {}
