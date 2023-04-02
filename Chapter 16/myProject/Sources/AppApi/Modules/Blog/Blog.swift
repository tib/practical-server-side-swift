public enum Blog: ApiModuleInterface {

    public enum Post: ApiModelInterface {
        public typealias Module = Blog
    }

    public enum Category: ApiModelInterface {
        public typealias Module = Blog

        public static let pathKey: String = "categories"
    }
}
