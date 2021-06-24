import Vapor

public protocol ModuleInterface {
    
    static var key: String { get }
    static var pathComponent: PathComponent { get }
    static var name: String { get }

    func boot(_ app: Application) throws
}

public extension ModuleInterface {
    func boot(_ app: Application) throws {}

    static var pathComponent: PathComponent { .init(stringLiteral: key) }
    static var name: String { key.capitalized }
}
