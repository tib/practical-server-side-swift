import Vapor
import Fluent

struct FrontendModule: Module {
    
    static var name: String = "frontend"
    
    var router: RouteCollection? { FrontendRouter() }
}
