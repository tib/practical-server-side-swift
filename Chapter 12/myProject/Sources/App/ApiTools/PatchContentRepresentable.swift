import Vapor

protocol PatchContentRepresentable: GetContentRepresentable {
    associatedtype PatchContent: ValidatableContent
    func patch(_: PatchContent) throws
}

extension PatchContentRepresentable {
    func patch(_: PatchContent) throws {}
}

