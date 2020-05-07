import Vapor

protocol GetContentRepresentable {
    associatedtype GetContent: Content

    var getContent: GetContent { get }
}
