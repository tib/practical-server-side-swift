//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

public struct OptionContext {

    public var key: String
    public var label: String

    public init(key: String, label: String) {
        self.key = key
        self.label = label
    }
}

public extension OptionContext {

    static func yesNo() -> [OptionContext] {
        ["yes", "no"].map { .init(key: $0, label: $0.capitalized) }
    }

    static func trueFalse() -> [OptionContext] {
        [true, false].map { .init(key: String($0), label: String($0).capitalized) }
    }

    static func numbers(_ numbers: [Int]) -> [OptionContext] {
        numbers.map { .init(key: String($0), label: String($0)) }
    }
}
