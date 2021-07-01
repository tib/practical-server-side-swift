import Vapor
import Fluent

public protocol ModelInterface: Fluent.Model where Self.IDValue == UUID {
    
    associatedtype Module: ModuleInterface

    static var key: String { get }
    static var idParamKey: String { get }
    static var createParamKey: String { get }
    static var updateParamKey: String { get }
    static var deleteParamKey: String { get }

    static var pathComponent: PathComponent { get }
    static var idPathComponent: PathComponent { get }
    static var createPathComponent: PathComponent { get }
    static var updatePathComponent: PathComponent { get }
    static var deletePathComponent: PathComponent { get }

    static var name: Noun { get }
}

public extension ModelInterface {
    static var schema: String { Module.key + "_" + key }
    static var idParamKey: String { key + "Id" }
    
    static var name: Noun { .init(singular: key) }
    
    static var createParamKey: String { "create" }
    static var updateParamKey: String { "update" }
    static var deleteParamKey: String { "delete" }
    
    static var pathComponent: PathComponent { .init(stringLiteral: key) }
    static var idPathComponent: PathComponent { .init(stringLiteral: ":" + idParamKey) }
    static var createPathComponent: PathComponent { .init(stringLiteral: createParamKey) }
    static var updatePathComponent: PathComponent { .init(stringLiteral: updateParamKey) }
    static var deletePathComponent: PathComponent { .init(stringLiteral: deleteParamKey) }
}

