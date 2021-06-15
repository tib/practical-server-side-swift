import Foundation
import Vapor
import Fluent

protocol ModelController {
    associatedtype Model: Fluent.Model
}
