import Vapor
import Fluent
import ViperKit

struct AdminModule: ViperModule {
    
    static var name: String = "admin"

    var router: ViperRouter? { AdminRouter() }
}
