import Foundation
import Fluent

struct BlogMigration_v1_0_0: Migration {

    private func uncategorizedPosts(for category: BlogCategoryModel) -> [BlogPostModel] {
        [
            BlogPostModel(title: "California",
                          slug: "california",
                          image: "/images/posts/03.jpg",
                          excerpt: "Voluptates ipsa eos sit distinctio.",
                          date: DateFormatter.year.date(from: "2015")!,
                          content: "Et non reiciendis et illum corrupti. Et ducimus optio commodi molestiae quis ipsum consequatur. A fugit amet amet qui tenetur. Aut voluptates ut labore consectetur temporibus consectetur. Perferendis et neque id minima voluptatem temporibus a dolor. Eos nihil dignissimos consequuntur et consequuntur nam.",
                          categoryId: category.id!),
        ]
    }

    private func islandPosts(for category: BlogCategoryModel) -> [BlogPostModel] {
        [
            BlogPostModel(title: "Indonesia",
                          slug: "indonesia",
                          image: "/images/posts/05.jpg",
                          excerpt: "Et excepturi id harum ipsam doloremque.",
                          date: DateFormatter.year.date(from: "2019")!,
                          content: "Accusantium amet vero numquam tenetur sit quidem ut. Officiis in iste adipisci corporis. Nisi aut consequatur laudantium et veritatis aut amet officiis. Repellat sapiente quis cupiditate veniam est. Est tempora molestiae voluptatum excepturi eum. Eos provident labore quidem ipsam.",
                          categoryId: category.id!),
            
            BlogPostModel(title: "Mauritius",
                          slug: "mauritius",
                          image: "/images/posts/04.jpg",
                          excerpt: "Pariatur debitis quod occaecati quidem. ",
                          date: DateFormatter.year.date(from: "2016")!,
                          content: "Enim et a ex quisquam qui sed fuga consectetur. Dolorem et eum non dicta modi tempora facilis. Totam dolores repudiandae magni autem doloremque. Libero consequuntur et distinctio esse a consectetur. Fugit quis sed provident est sunt. Rerum quibusdam blanditiis optio autem.",
                          categoryId: category.id!),
            
            BlogPostModel(title: "The Maldives",
                          slug: "the-maldives",
                          image: "/images/posts/02.jpg",
                          excerpt: "Possimus est labore recusandae asperiores fuga sequi sit.",
                          date: DateFormatter.year.date(from: "2014")!,
                          content: "Dignissimos mollitia doloremque omnis repellendus quibusdam ut amet. Autem vitae enim consequuntur. Quis quo esse numquam doloremque esse. Neque accusantium sint tempore distinctio. Dolorem quibusdam et ab impedit necessitatibus cum. Eius voluptatem ducimus velit non.",
                          categoryId: category.id!),
            
            BlogPostModel(title: "Sri Lanka",
                          slug: "sri-lanka",
                          image: "/images/posts/01.jpg",
                          excerpt: "Ratione est quo nemo dolor placeat dolore.",
                          date: DateFormatter.year.date(from: "2014")!,
                          content: "Deserunt nulla culpa aspernatur ea a accusantium quia quibusdam. Ducimus delectus ea ipsa quisquam aut in deleniti quia. Error aliquam harum earum. Quos dignissimos dolores ratione illo. Dolores velit sunt sed quas quis itaque sit omnis. Molestias explicabo aut eum amet blanditiis quia similique soluta.",
                          categoryId: category.id!),
        ]
    }
    

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(BlogCategoryModel.schema)
                .id()
                .field(BlogCategoryModel.FieldKeys.title, .string, .required)
                .create(),
            database.schema(BlogPostModel.schema)
                .id()
                .field(BlogPostModel.FieldKeys.title, .string, .required)
                .field(BlogPostModel.FieldKeys.slug, .string, .required)
                .field(BlogPostModel.FieldKeys.image, .string, .required)
                .field(BlogPostModel.FieldKeys.excerpt, .string, .required)
                .field(BlogPostModel.FieldKeys.date, .datetime, .required)
                .field(BlogPostModel.FieldKeys.content, .string, .required)
                .field(BlogPostModel.FieldKeys.categoryId, .uuid)
                .foreignKey(BlogPostModel.FieldKeys.categoryId,
                            references: BlogCategoryModel.schema, .id,
                            onDelete: .cascade,
                            onUpdate: .cascade)
                .unique(on: BlogPostModel.FieldKeys.slug)
                .create(),
        ])
        .flatMap {
            let defaultCategory = BlogCategoryModel(title: "Uncategorized")
            let islandsCategory = BlogCategoryModel(title: "Islands")
            return [defaultCategory, islandsCategory].create(on: database)
            .flatMap { [unowned defaultCategory] in
                let posts = self.uncategorizedPosts(for: defaultCategory) +
                            self.islandPosts(for: islandsCategory)
                return posts.create(on: database)
            }
        }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(BlogCategoryModel.schema).delete(),
            database.schema(BlogPostModel.schema).delete(),
        ])
    }
}
