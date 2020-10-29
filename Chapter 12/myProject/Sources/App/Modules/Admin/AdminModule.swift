import Vapor
import Fluent

struct AdminModule: Module {
    
    var name: String = "admin"
    
    var router: RouteCollection? { AdminRouter() }
}
