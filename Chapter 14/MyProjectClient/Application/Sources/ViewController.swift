//
//  ViewController.swift
//  MyProject
//
//  Created by Tibor Bodecs on 2020. 05. 15..
//  Copyright © 2020. Tibor Bodecs. All rights reserved.
//

import UIKit
import MyProjectApi

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(BlogCategoryGetObject(id: .init(), title: ""))
    }


}

