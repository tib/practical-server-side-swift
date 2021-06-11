import Vapor

struct BlogCommandGroup: CommandGroup {

    let commands: [String: AnyCommand]
    let help: String
    
    var defaultCommand: AnyCommand? {
        commands[BlogFileTransferCommand.name]
    }

    init() {
        help = "Various blog tools"

        commands = [
            BlogFileTransferCommand.name: BlogFileTransferCommand(),
        ]
    }
}
