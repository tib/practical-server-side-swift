import Vapor

@main
public struct myProject {

    public static func main() throws {
        let env = try Environment.detect()
        let app = Application(env)
        defer { app.shutdown() }
        app.get { req in "Hello Vapor!" }
        try app.run()
    }
}
