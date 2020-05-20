import Vapor

protocol UpdateContentRepresentable: GetContentRepresentable {
    associatedtype UpdateContent: ValidatableContent
    func update(_: UpdateContent) throws
}

extension UpdateContentRepresentable {
    func update(_: UpdateContent) throws {}
}

