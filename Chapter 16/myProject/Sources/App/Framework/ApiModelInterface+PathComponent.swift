import Vapor
import AppApi

extension ApiModelInterface {

    static var pathIdComponent: PathComponent {
        .init(stringLiteral: ":" + pathIdKey)
    }
}
