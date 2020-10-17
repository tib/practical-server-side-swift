import Foundation
import Leaf

struct BlogPost: Encodable {
    let title: String
    let slug: String
    let image: String
    let excerpt: String
    let date: Date
    let category: String?
    let content: String
}
