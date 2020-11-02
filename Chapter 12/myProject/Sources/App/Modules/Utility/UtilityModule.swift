import Vapor
import Fluent

struct UtilityModule: ViperModule {

    static var name: String = "utility"

    var commandGroup: CommandGroup? { UtilityCommandGroup() }
}
