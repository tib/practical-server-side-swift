import Vapor
import Fluent
import LoremSwiftum

struct BlogMigrationSeed: Migration {
    
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        let categories = stride(from: 0, to: 3, by: 1).map { _ in BlogCategoryModel(title: Lorem.title) }
        
        return categories.create(on: db).flatMap {
            let posts = stride(from: 0, to: 10, by: 1).map { index -> BlogPostModel in
                let categoryId = categories.randomElement()!.id!
                let title = Lorem.title
                return BlogPostModel(title: title,
                                     slug: title.lowercased().replacingOccurrences(of: " ", with: "-"),
                                     image: "/images/posts/\(String(format: "%02d", index + 1)).jpg",
                                     excerpt: Lorem.sentence,
                                     date: Date().addingTimeInterval(-Double.random(in: 0...(86400 * 60))),
                                     content: Lorem.paragraph,
                                     categoryId: categoryId)
            }
            return posts.create(on: db)
        }
    }
    
    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            BlogPostModel.query(on: db).delete(),
            BlogCategoryModel.query(on: db).delete(),
        ])
    }
}




