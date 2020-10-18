import Vapor
import Fluent

struct UtilityModule: Module {

    var name: String = "utility"

    var commandGroup: CommandGroup? { UtilityCommandGroup() }
}
