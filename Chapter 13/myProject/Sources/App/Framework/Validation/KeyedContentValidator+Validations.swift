import Vapor

public extension KeyedContentValidator where T == String {

    static func required(
        _ key: String,
        _ message: String? = nil,
        optional: Bool = false
    ) -> KeyedContentValidator<T> {
        let msg = message ?? "\(key.capitalized) is required"
        return .init(key, msg, optional: optional) { value, _ in
            !value.isEmpty
        }
    }
        
    static func min(
        _ key: String,
        _ length: Int,
        _ message: String? = nil,
        optional: Bool = false
    ) -> KeyedContentValidator<T> {
        let msg = message ?? "\(key.capitalized) is too short (min: \(length) characters)"
        return .init(key, msg, optional: optional) { value, _ in
            value.count >= length
        }
    }
    
    static func max(
        _ key: String,
        _ length: Int,
        _ message: String? = nil,
        optional: Bool = false
    ) -> KeyedContentValidator<T> {
            let msg = message ?? "\(key.capitalized) is too long (max: \(length) characters)"
        return .init(key, msg, optional: optional) { value, _ in
            value.count <= length
        }
    }

    static func alphanumeric(
        _ key: String,
        _ message: String? = nil,
        _ optional: Bool = false
    ) -> KeyedContentValidator<T> {
            let msg = message ?? "\(key.capitalized) should be only alphanumeric characters"
        return .init(key, msg, optional: optional) { value, _ in
            !Validator.characterSet(.alphanumerics).validate(value).isFailure
        }
    }

    static func email(
        _ key: String,
        _ message: String? = nil,
        _ optional: Bool = false
    ) -> KeyedContentValidator<T> {
        let msg = message ?? "\(key.capitalized) should be a valid email address"
        return .init(key, msg, optional: optional) { value, _ in
            !Validator.email.validate(value).isFailure
        }
    }
}

public extension KeyedContentValidator where T == Int {

    static func min(
        _ key: String,
        _ length: Int,
        _ message: String? = nil,
        optional: Bool = false
    ) -> KeyedContentValidator<T> {
            let msg = message ?? "\(key.capitalized) is too short (min: \(length) characters)"
        return .init(key, msg, optional: optional) { value, _ in
            value >= length
        }
    }
    
    static func max(
        _ key: String,
        _ length: Int,
        _ message: String? = nil,
        optional: Bool = false
    ) -> KeyedContentValidator<T> {
            let msg = message ?? "\(key.capitalized) is too long (max: \(length) characters)"
        return .init(key, msg, optional: optional) { value, _ in
            value <= length
        }
    }

    static func contains(
        _ key: String,
        _ values: [Int],
        _ message: String? = nil,
        optional: Bool = false
    ) -> KeyedContentValidator<T> {
            let msg = message ?? "\(key.capitalized) is an invalid value"
        return .init(key, msg, optional: optional) { value, _ in
            values.contains(value)
        }
    }
}

public extension KeyedContentValidator where T == UUID {

    static func required(
        _ key: String,
        _ message: String? = nil,
        optional: Bool = false
    ) -> KeyedContentValidator<T> {
        let msg = message ?? "\(key.capitalized) is required"
        return .init(key, msg, optional: optional) { _, _ in
            true
        }
    }
}
