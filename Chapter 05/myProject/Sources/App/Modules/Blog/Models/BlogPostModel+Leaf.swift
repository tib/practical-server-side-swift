import Leaf

extension BlogPostModel {

    var viewContext: LeafData {
        .dictionary([
            "id": .string(id!.uuidString),
            "title": .string(title),
            "slug": .string(slug),
            "image": .string(image),
            "excerpt": .string(excerpt),
            "date": .double(date.timeIntervalSince1970),
            "content": .string(content),
            "category": $category.value != nil ? category.viewContext : .trueNil,
        ])
    }
}
