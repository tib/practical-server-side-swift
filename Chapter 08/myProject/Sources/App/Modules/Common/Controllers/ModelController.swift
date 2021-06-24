import Vapor
import Fluent

protocol ModelController {
    associatedtype Model: ModelInterface
}
