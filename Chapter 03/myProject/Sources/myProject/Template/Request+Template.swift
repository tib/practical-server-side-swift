import Vapor

public extension Request {
    var templates: TemplateRenderer { .init(self) }
}
