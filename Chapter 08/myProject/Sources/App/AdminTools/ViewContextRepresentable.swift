import Foundation

public protocol ViewContextRepresentable {
    associatedtype ViewContext: Encodable

    var viewContext: ViewContext { get }
    var viewIdentifier: String { get }
}

