import Vapor

var env = try Environment.detect()
let app = Application(env)
defer { app.shutdown() }
app.get { req in "Hello Vapor!" }
try app.run()
