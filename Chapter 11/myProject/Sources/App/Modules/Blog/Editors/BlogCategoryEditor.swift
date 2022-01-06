//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

import Vapor

struct BlogCategoryEditor: ModelEditorInterface {
    let model: BlogCategoryModel
    let form: AbstractForm

    init(model: BlogCategoryModel, form: AbstractForm) {
        self.model = model
        self.form = form
    }

    @FormComponentBuilder
    var formFields: [FormComponent] {
        InputField("title")
            .config {
                $0.output.context.label.required = true
            }
            .validators {
                FormFieldValidator.required($1)
            }
            .read { $1.output.context.value = model.title }
            .write { model.title = $1.input }
    }
}
