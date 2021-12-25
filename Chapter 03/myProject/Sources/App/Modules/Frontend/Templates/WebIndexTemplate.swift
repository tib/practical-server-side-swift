//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import SwiftHtml
import SwiftSvg

extension Svg {
    static func menuIcon() -> Svg {
        Svg {
            Line(x1: 3, y1: 12, x2: 21, y2: 12)
            Line(x1: 3, y1: 6, x2: 21, y2: 6)
            Line(x1: 3, y1: 18, x2: 21, y2: 18)
        }
        .width(24)
        .height(24)
        .viewBox(minX: 0, minY: 0, width: 24, height: 24)
        .fill("none")
        .stroke("currentColor")
        .strokeWidth(2)
        .strokeLinecap("round")
        .strokeLinejoin("round")
    }
}

public struct WebIndexTemplate: TemplateRepresentable {

    unowned var req: Request
    public var context: String
    var body: Tag

    public init(_ req: Request, context: String, @TagBuilder _ builder: () -> Tag) {
        self.req = req
        self.context = context
        self.body = builder()
    }

    public var tag: Tag {
        Html {
            Head {
                Title(context)

                Meta()
                    .charset("utf-8")
                
                Meta()
                    .name(.viewport)
                    .content("width=device-width, initial-scale=1")
                
                //TODO: shortcut icon
                Link(rel: .icon)
                    .href("/images/favicon.ico")
                    .type("image/x-icon")
                Link(rel: .stylesheet)
                    .href("https://cdn.jsdelivr.net/gh/feathercms/feather-core@1.0.0-beta.44/feather.min.css")
                Link(rel: .stylesheet)
                    .href("/css/frontend.css")
            }
            Body {
                Header {
                    Div {
                        A {
                            Img(src: "/img/logo.png", alt: "Logo")
                        }
                        .id("site-logo")
                        .href("/")
                        
                        Nav {
                            Input()
                                .type(.checkbox)
                                .id("primary-menu-button")
                                .name("menu-button")
                                .class("menu-button")
                            Label {
                                Svg.menuIcon()
                            }
                            .for("primary-menu-button")
                            Div {
                                A("Home")
                                    .href("/")
                                    .class("selected", req.url.path == "/")
                                A("Blog")
                                    .href("/blog/")
                                    .class("selected", req.url.path == "/blog/")
                                A("About")
                                    .href("#")
                                    .onClick("javascript:about();")
                            }
                            .class("menu-items")
                        }
                        .id("primary-menu")
                    }
                    .id("navigation")
                }
                
                Main {
                    body
                }

                Footer {
                    Section {
                        P {
                            Text("This site is powered by ")
                            A("Swift")
                                .href("https://swift.org")
                                .target(.blank)
                            Text(" & ")
                            A("Vapor")
                                .href("https://vapor.codes")
                                .target(.blank)
                            Text(".")
                        }
                        P("myPage &copy; 2020-2022")
                    }
                }
                
                Script()
                    .type(.javascript)
                    .src("/js/frontend.js")
                
            }
        }
        .lang("en-US")
    }
    
}