import Foundation
import Tau

struct BlogPost {
    let title: String
    let slug: String
    let image: String
    let excerpt: String
    let date: Date
    let category: String?
    let content: String
}

extension BlogPost: TemplateDataRepresentable {
    
    var templateData: TemplateData {
        .dictionary([
            "title": .string(title),
            "slug": .string(slug),
            "image": .string(image),
            "excerpt": .string(excerpt),
            "date": .double(date.timeIntervalSinceReferenceDate),
            "category": .string(category),
            "content": .string(content),
        ])
    }
}
