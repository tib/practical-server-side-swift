public protocol ApiModuleInterface {
    static var pathKey: String { get }
}

public extension ApiModuleInterface {

    static var pathKey: String {
        String(describing: self).lowercased()
    }
}
