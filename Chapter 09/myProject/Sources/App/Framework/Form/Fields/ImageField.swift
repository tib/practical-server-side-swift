//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor

public final class ImageField: AbstractFormField<FormImageInput, ImageFieldTemplate> {

    public var imageKey: String? {
        didSet {
            output.context.data.originalKey = imageKey
        }
    }

    public var path: String

    public init(_ key: String, path: String) {
        self.path = path
        super.init(key: key, input: .init(key: key), output: .init(.init(key: key)))
    }

    public override func process(req: Request) async throws {
        /// process input
        input.file = try? req.content.get(File.self, at: key)
        input.data.originalKey = try? req.content.get(String.self, at: key + "OriginalKey")
        if
            let temporaryFileKey = try? req.content.get(String.self, at: key + "TemporaryFileKey"),
            let temporaryFileName = try? req.content.get(String.self, at: key + "TemporaryFileName")
        {
            input.data.temporaryFile = .init(key: temporaryFileKey, name: temporaryFileName)
        }
        input.data.shouldRemove = (try? req.content.get(Bool.self, at: key + "ShouldRemove")) ?? false

        /// remove & upload file
        if input.data.shouldRemove {
            if let originalKey = input.data.originalKey {
                try? await req.fs.delete(key: originalKey)
            }
        }
        else if let file = input.file, let data = file.byteBuffer.data, !data.isEmpty {
            if let tmpKey = input.data.temporaryFile?.key {
                try? await req.fs.delete(key: tmpKey)
            }
            let key = "tmp/\(UUID().uuidString).tmp"

            _ = try await req.fs.upload(key: key, data: data)
            /// update the temporary image
            input.data.temporaryFile = .init(key: key, name: file.filename)
        }
        /// update output values
        output.context.data = input.data

    }
    
    public override func write(req: Request) async throws {
        imageKey = input.data.originalKey
        if input.data.shouldRemove {
            if let key = input.data.originalKey {
                try? await req.fs.delete(key: key)
            }
            imageKey = nil
        }
        else if let file = input.data.temporaryFile {
            var newKey = path + "/" + file.name
            if await req.fs.exists(key: newKey) {
                let formatter = DateFormatter()
                formatter.dateFormat="y-MM-dd-HH-mm-ss-"
                let prefix = formatter.string(from: .init())
                newKey = path + "/" + prefix + file.name
            }

            _ = try await req.fs.move(key: file.key, to: newKey)
            input.data.temporaryFile = nil
            if let key = input.data.originalKey {
                try? await req.fs.delete(key: key)
            }
            imageKey = newKey
        }
        try await super.write(req: req)
    }
    

    public override func render(req: Request) -> TemplateRepresentable {
        output.context.error = error
        return super.render(req: req)
    }
}
