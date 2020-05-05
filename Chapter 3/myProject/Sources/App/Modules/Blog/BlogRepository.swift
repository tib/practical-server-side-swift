import Vapor

struct BlogRepository {
    
    func publishedPosts() -> [BlogPost] {
        [
            BlogPost(title: "Indonesia",
                     slug: "indonesia",
                     image: "/images/posts/05.jpg",
                     excerpt: "Et excepturi id harum ipsam doloremque.",
                     date: "2019",
                     category: "Islands",
                     content: "Accusantium amet vero numquam tenetur sit quidem ut. Officiis in iste adipisci corporis. Nisi aut consequatur laudantium et veritatis aut amet officiis. Repellat sapiente quis cupiditate veniam est. Est tempora molestiae voluptatum excepturi eum. Eos provident labore quidem ipsam."),
            
            BlogPost(title: "Mauritius",
                     slug: "mauritius",
                     image: "/images/posts/04.jpg",
                     excerpt: "Pariatur debitis quod occaecati quidem. ",
                     date: "2016",
                     category: "Islands",
                     content: "Enim et a ex quisquam qui sed fuga consectetur. Dolorem et eum non dicta modi tempora facilis. Totam dolores repudiandae magni autem doloremque. Libero consequuntur et distinctio esse a consectetur. Fugit quis sed provident est sunt. Rerum quibusdam blanditiis optio autem."),
            
            BlogPost(title: "California",
                     slug: "california",
                     image: "/images/posts/03.jpg",
                     excerpt: "Voluptates ipsa eos sit distinctio.",
                     date: "2015",
                     category: nil,
                     content: "Et non reiciendis et illum corrupti. Et ducimus optio commodi molestiae quis ipsum consequatur. A fugit amet amet qui tenetur. Aut voluptates ut labore consectetur temporibus consectetur. Perferendis et neque id minima voluptatem temporibus a dolor. Eos nihil dignissimos consequuntur et consequuntur nam."),
            
            BlogPost(title: "The Maldives",
                     slug: "the-maldives",
                     image: "/images/posts/02.jpg",
                     excerpt: "Possimus est labore recusandae asperiores fuga sequi sit.",
                     date: "2014",
                     category: "Islands",
                     content: "Dignissimos mollitia doloremque omnis repellendus quibusdam ut amet. Autem vitae enim consequuntur. Quis quo esse numquam doloremque esse. Neque accusantium sint tempore distinctio. Dolorem quibusdam et ab impedit necessitatibus cum. Eius voluptatem ducimus velit non."),
            
            BlogPost(title: "Sri Lanka",
                     slug: "sri-lanka",
                     image: "/images/posts/01.jpg",
                     excerpt: "Ratione est quo nemo dolor placeat dolore.",
                     date: "2014",
                     category: "Islands",
                     content: "Deserunt nulla culpa aspernatur ea a accusantium quia quibusdam. Ducimus delectus ea ipsa quisquam aut in deleniti quia. Error aliquam harum earum. Quos dignissimos dolores ratione illo. Dolores velit sunt sed quas quis itaque sit omnis. Molestias explicabo aut eum amet blanditiis quia similique soluta."),
        ]
    }
}
