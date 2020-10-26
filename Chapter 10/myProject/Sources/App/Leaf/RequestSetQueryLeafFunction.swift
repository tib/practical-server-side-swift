import Leaf

public struct RequestSetQueryLeafFunction: LeafUnsafeEntity, StringReturn {
    public var unsafeObjects: UnsafeObjects? = nil
    
    public static var callSignature: [LeafCallParameter] { [.init(label: "setQuery", types: [.dictionary])] }
    
    public func evaluate(_ params: LeafCallValues) -> LeafData {
        guard let req = req else { return .error("Needs unsafe access to Request") }

        var queryItems: [String: String] = [:]
        for item in (req.url.query ?? "").split(separator: "&") {
            let array = item.split(separator: "=")
            guard array.count == 2 else {
                continue
            }
            let k = String(array[0])
            let v = String(array[1])
            queryItems[k] = v
        }

        guard let dict = params[0].dictionary else {
            return .error("Invalid dictionary parameter")
        }
        for key in dict.keys {
            guard let value = dict[key]?.string else { return .error("Invalid dictionary value") }
            queryItems[key] = value
        }

        let queryString = queryItems.map { $0 + "=" + $1 }.joined(separator: "&")
        return .string("\(req.url.path)?\(queryString)")
    }
}
