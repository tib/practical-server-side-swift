//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 03..
//

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
