import Vapor
import SwiftHtml

func routes(_ app: Application) throws {

    app.routes.get { req -> Response in
        req.templates.renderHtml(
            WebIndexTemplate(
                WebIndexContext(
                    title: "Home"
                )
            ) {
                P("Hi there, welcome to my page!")
            }
        )
    }
}
