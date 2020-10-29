import Vapor

protocol ListContentRepresentable {
    associatedtype ListItem: Content

    var listContent: ListItem { get }
}
