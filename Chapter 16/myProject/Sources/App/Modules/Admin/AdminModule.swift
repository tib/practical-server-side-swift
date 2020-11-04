import Vapor
import Fluent

struct AdminModule: ViperModule {
    
    static var name: String = "admin"
    
    var router: ViperRouter? { AdminRouter() }
}
