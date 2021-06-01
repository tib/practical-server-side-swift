import Foundation
import Vapor

final class TextField: FormField<String, TextFieldView> {

    convenience init(key: String) {
        self.init(key: key, input: "", output: .init(key: key))
    }

    override func process(req: Request) -> EventLoopFuture<Void> {
        super.process(req: req).map { [unowned self] in
            output.value = input
        }
    }
}
