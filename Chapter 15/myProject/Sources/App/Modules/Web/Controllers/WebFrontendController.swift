//
//  WebFrontendController.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor

struct WebFrontendController {
    
    func homeView(req: Request) throws -> Response {
        let ctx = WebHomeContext(icon: "👋",
                                 title: "Home",
                                 message: "Hi there, welcome to my page.",
                                 paragraphs: [
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                    "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
                                    "Nisi ut aliquip ex ea commodo consequat.",
                                 ],
                                 link: .init(label: "Read my blog →", url: "/blog/"))

        return req.templates.renderHtml(WebHomeTemplate(ctx))
    }
}
