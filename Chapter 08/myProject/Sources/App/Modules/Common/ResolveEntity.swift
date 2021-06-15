//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 06. 09..
//

import Foundation
import Vapor
import Liquid
import Tau

struct ResolveEntity: UnsafeEntity, NonMutatingMethod, StringReturn {
    
    var unsafeObjects: UnsafeObjects? = nil
    
    static var callSignature: [CallParameter] { [.string] }
    
    func evaluate(_ params: CallValues) -> TemplateData {
        guard let req = req else { return .error("Needs unsafe access to Request") }

        return .string(req.fs.resolve(key: params[0].string!))
    }
}
