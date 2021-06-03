import Tau

extension BlogPostModel: TemplateDataRepresentable {

    var templateData: TemplateData {
        .dictionary([
            "id": .string(id?.uuidString),
            "title": .string(title),
            "slug": .string(slug),
            "image": .string(image),
            "excerpt": .string(excerpt),
            "date": .double(date.timeIntervalSinceReferenceDate),
            "content": .string(content),
            "category": $category.value != nil ? category.templateData : .dictionary(nil),
        ])
    }
}
