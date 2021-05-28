import Tau

extension BlogCategoryModel: TemplateDataRepresentable {

    var templateData: TemplateData {
        .dictionary([
            "id": .string(id?.uuidString),
            "title": .string(title),
        ])
    }
}
