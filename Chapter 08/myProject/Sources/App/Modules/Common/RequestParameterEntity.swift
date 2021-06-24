import Vapor
import Tau

struct RequestParameterEntity: UnsafeEntity, StringReturn {

    var unsafeObjects: UnsafeObjects? = nil
    
    static var callSignature: [CallParameter] { [.string(labeled: "parameter")] }

    func evaluate(_ params: CallValues) -> TemplateData {
        guard let req = req else { return .error("Needs unsafe access to Request") }
        return .string(req.parameters.get(params[0].string!))
    }
}
