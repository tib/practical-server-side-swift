import Vapor
import Fluent

struct AdminModule: Module {
    
    static var name: String = "admin"

    var router: RouteCollection? { AdminRouter() }
}
