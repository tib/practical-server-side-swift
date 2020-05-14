import Vapor
import Fluent
import ViperKit

struct FrontendModule: ViperModule {
    
    static var name: String = "frontend"
    
    var router: ViperRouter? { FrontendRouter() }
}
