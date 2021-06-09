import Foundation
import Vapor

final class SelectionField: FormField<String, SelectionFieldView> {

    public convenience init(key: String, value: String, options: [FormFieldOption] = []) {
        self.init(key: key, input: value, output: .init(key: key, value: value, options: options))
    }
    
    override func process(req: Request) -> EventLoopFuture<Void> {
        super.process(req: req).map { [unowned self] in
            output.value = input
        }
    }
}
