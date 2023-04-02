enum Blog: ApiModuleInterface {

    enum Post: ApiModelInterface {
        typealias Module = Blog
    }

    enum Category: ApiModelInterface {
        typealias Module = Blog

        static let pathKey: String = "categories"
    }
}
