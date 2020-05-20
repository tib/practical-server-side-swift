import Vapor
import Fluent

struct AdminModule: Module {

    var router: RouteCollection? { AdminRouter() }
}
