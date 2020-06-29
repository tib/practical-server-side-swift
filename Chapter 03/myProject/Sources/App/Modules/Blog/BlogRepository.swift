import Vapor

struct BlogRepository {
    
    func publishedPosts() -> [BlogPost] {
        [
            BlogPost(title: "Indonesia",
                     slug: "indonesia",
                     image: "/images/posts/05.jpg",
                     excerpt: "Et excepturi id harum ipsam doloremque",
                     date: "2019",
                     category: "Islands",
                     content: "Accusantium amet vero numquam tenetur sit quidem ut..."),
            
            BlogPost(title: "Mauritius",
                     slug: "mauritius",
                     image: "/images/posts/04.jpg",
                     excerpt: "Pariatur debitis quod occaecati quidem",
                     date: "2016",
                     category: "Islands",
                     content: "Enim et a ex quisquam qui sed fuga consectetur..."),
            
            BlogPost(title: "California",
                     slug: "california",
                     image: "/images/posts/03.jpg",
                     excerpt: "Voluptates ipsa eos sit distinctio",
                     date: "2015",
                     category: nil,
                     content: "Et non reiciendis et illum corrupti..."),
            
            BlogPost(title: "The Maldives",
                     slug: "the-maldives",
                     image: "/images/posts/02.jpg",
                     excerpt: "Possimus est labore recusandae asperiores",
                     date: "2014",
                     category: "Islands",
                     content: "Dignissimos mollitia doloremque omnis repellendus..."),
            
            BlogPost(title: "Sri Lanka",
                     slug: "sri-lanka",
                     image: "/images/posts/01.jpg",
                     excerpt: "Ratione est quo nemo dolor placeat dolore",
                     date: "2014",
                     category: "Islands",
                     content: "Deserunt nulla culpa aspernatur ea a accusantium..."),
        ]
    }
}
