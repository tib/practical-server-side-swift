import Vapor

protocol CreateContentRepresentable: GetContentRepresentable {
    associatedtype CreateContent: ValidatableContent

    func create(_: CreateContent) throws
}

extension CreateContentRepresentable {
    func create(_: CreateContent) throws {}
}
