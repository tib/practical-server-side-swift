import Vapor
import Fluent
import ViperKit

struct UtilityModule: ViperModule {

    static var name: String = "utility"

    var commandGroup: CommandGroup? { UtilityCommandGroup() }
}
