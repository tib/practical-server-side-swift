/// FILE: Sources/App/Template/TemplateRepresentable.swift

import Vapor
import SwiftSgml

public protocol TemplateRepresentable {
    
    @TagBuilder
    func render(_ req: Request) -> Tag
}
