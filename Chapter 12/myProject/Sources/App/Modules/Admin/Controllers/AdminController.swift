//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 06..
//

import Vapor

protocol AdminController: AdminListController,
                          AdminDetailController,
                          AdminCreateController,
                          AdminUpdateController,
                          AdminDeleteController
{
    
}

extension AdminController {
    
}

