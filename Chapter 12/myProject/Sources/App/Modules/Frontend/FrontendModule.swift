import Vapor
import Fluent

struct FrontendModule: ViperModule {

    static var name: String = "frontend"
    
    var router: ViperRouter? { FrontendRouter() }
}
