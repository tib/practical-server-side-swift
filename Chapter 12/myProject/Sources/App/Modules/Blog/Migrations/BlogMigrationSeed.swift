import Vapor
import Fluent

struct BlogMigrationSeed: Migration {
    
    private func uncategorizedPosts(for category: BlogCategoryModel) -> [BlogPostModel] {
        [
            .init(title: "California",
                  slug: "california",
                  image: "/images/posts/03.jpg",
                  excerpt: "Voluptates ipsa eos sit distinctio",
                  date: DateFormatter.year.date(from: "2015")!,
                  content: "Et non reiciendis et illum corrupti...",
                  categoryId: category.id!),
        ]
    }
    
    private func islandPosts(for category: BlogCategoryModel) -> [BlogPostModel] {
        [
            .init(title: "Indonesia",
                  slug: "indonesia",
                  image: "/images/posts/05.jpg",
                  excerpt: "Et excepturi id harum ipsam doloremque",
                  date: DateFormatter.year.date(from: "2019")!,
                  content: "Accusantium amet vero numquam tenetur sit quidem ut...",
                  categoryId: category.id!),
            
            .init(title: "Mauritius",
                  slug: "mauritius",
                  image: "/images/posts/04.jpg",
                  excerpt: "Pariatur debitis quod occaecati quidem",
                  date: DateFormatter.year.date(from: "2016")!,
                  content: "Enim et a ex quisquam qui sed fuga consectetur...",
                  categoryId: category.id!),
            
            .init(title: "The Maldives",
                  slug: "the-maldives",
                  image: "/images/posts/02.jpg",
                  excerpt: "Possimus est labore recusandae asperiores",
                  date: DateFormatter.year.date(from: "2014")!,
                  content: "Dignissimos mollitia doloremque omnis repellendus...",
                  categoryId: category.id!),
            
            .init(title: "Sri Lanka",
                  slug: "sri-lanka",
                  image: "/images/posts/01.jpg",
                  excerpt: "Ratione est quo nemo dolor placeat dolore",
                  date: DateFormatter.year.date(from: "2014")!,
                  content: "Deserunt nulla culpa aspernatur ea a accusantium...",
                  categoryId: category.id!),
        ]
    }
    
    
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        let defaultCategory = BlogCategoryModel(title: "Uncategorized")
        let islandsCategory = BlogCategoryModel(title: "Islands")
        return [defaultCategory, islandsCategory].create(on: db)
            .flatMap {
                let posts = self.uncategorizedPosts(for: defaultCategory) + self.islandPosts(for: islandsCategory)
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
