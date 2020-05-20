import Vapor
import Fluent

struct UtilityModule: Module {

    static var name: String = "utility"

    var commandGroup: CommandGroup? { UtilityCommandGroup() }
}
