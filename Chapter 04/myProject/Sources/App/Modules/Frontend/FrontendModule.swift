import Vapor
import Fluent

struct FrontendModule: Module {
    
    var router: RouteCollection? { FrontendRouter() }
}
