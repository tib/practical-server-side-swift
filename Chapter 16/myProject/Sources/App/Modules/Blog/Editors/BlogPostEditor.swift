//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 05..
//

import Vapor

struct BlogPostEditor: ModelEditorInterface {
    let model: BlogPostModel
    let form: AbstractForm

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    init(model: BlogPostModel, form: AbstractForm) {
        self.model = model
        self.form = form
    }

    @FormComponentBuilder
    var formFields: [FormComponent] {
        ImageField("image", path: "blog/post")
            .read {
                $1.output.context.previewUrl = model.imageKey
                ($1 as! ImageField).imageKey = model.imageKey
            }
            .write { model.imageKey = ($1 as! ImageField).imageKey ?? "" }
        
        InputField("slug")
            .config {
                $0.output.context.label.required = true
            }
            .validators {
                FormFieldValidator.required($1)
            }
            .read { $1.output.context.value = model.slug }
            .write { model.slug = $1.input }
        
        InputField("title")
            .config {
                $0.output.context.label.required = true
            }
            .validators {
                FormFieldValidator.required($1)
            }
            .read { $1.output.context.value = model.title }
            .write { model.title = $1.input }
        
        InputField("date")
            .config {
                $0.output.context.label.required = true
                $0.output.context.value = dateFormatter.string(from: Date())
            }
            .validators {
                FormFieldValidator.required($1)
            }
            .read { $1.output.context.value = dateFormatter.string(from: model.date) }
            .write { model.date = dateFormatter.date(from: $1.input) ?? Date() }
        
        TextareaField("excerpt")
            .read { $1.output.context.value = model.excerpt }
            .write { model.excerpt = $1.input }

        TextareaField("content")
            .read { $1.output.context.value = model.content }
            .write { model.content = $1.input }
        
        SelectField("category")
            .load { req, field in
                let categories = try await BlogCategoryModel.query(on: req.db).all()
                field.output.context.options = categories.map { OptionContext(key: $0.id!.uuidString, label: $0.title) }
            }
            .read { req, field in
                field.output.context.value = model.$category.id.uuidString
            }
            .write { req, field in
                if
                    let uuid = UUID(uuidString: field.input),
                    let category = try await BlogCategoryModel.find(uuid, on: req.db)
                {
                    model.$category.id = category.id!
                }
            }
    }
}
