import Vapor
import Fluent

struct FrontendModule: Module {

    var name: String = "frontend"
    
    var router: RouteCollection? { FrontendRouter() }
}
