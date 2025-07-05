import Vapor

let env = try Environment.detect()
let app = try await Application.make(env)

do {
    app.get { req in "Hello Vapor!" }
    try await app.execute()
}
catch {
    try? await app.asyncShutdown()
    throw error
}
try await app.asyncShutdown()
