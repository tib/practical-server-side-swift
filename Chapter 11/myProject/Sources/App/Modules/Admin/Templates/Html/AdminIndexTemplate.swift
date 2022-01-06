//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor
import SwiftHtml
import SwiftSvg

public struct AdminIndexTemplate: TemplateRepresentable {

    public var context: AdminIndexContext
    var body: Tag

    public init(_ context: AdminIndexContext, @TagBuilder _ builder: () -> Tag) {
        self.context = context
        self.body = builder()
    }

    @TagBuilder
    public func render(_ req: Request) -> Tag {
        Html {
            Head {
                Meta()
                    .charset("utf-8")
                Meta()
                    .name(.viewport)
                    .content("width=device-width, initial-scale=1")
                Meta()
                    .name("robots")
                    .content("noindex")
                Link(rel: .shortcutIcon)
                    .href("/images/favicon.ico")
                    .type("image/x-icon")
                Link(rel: .stylesheet)
                    .href("https://cdn.jsdelivr.net/gh/feathercms/feather-core@1.0.0-beta.44/feather.min.css")
                Link(rel: .stylesheet)
                    .href("/css/admin.css")
                
                Title(context.title)
            }
            Body {
                Div {
                    A {
                        Img(src: "/img/logo.png", alt: "Logo")
                            .title("Logo")
                            .style("width: 300px")
                    }
                    .href("/")
                    
                    Nav {
                        Input()
                            .type(.checkbox)
                            .id("secondary-menu-button")
                            .name("menu-button")
                            .class("menu-button")
                        Label {
                            Svg.menuIcon()
                        }
                        .for("secondary-menu-button")

                        Div {
                            A("Sign out")
                                .href("/sign-out/")
                        }
                        .class("menu-items")
                    }
                    .id("secondary-menu")
                }
                .id("navigation")
                
                Div {
                    Nav {
                        A("Admin")
                            .href("/admin/")

                        context.breadcrumbs.map { LinkTemplate($0).render(req) }
                    }
                }
                .class("breadcrumb")

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
                    .src("/js/admin.js")
                
            }
        }
        .lang("en-US")
    }
    
}

