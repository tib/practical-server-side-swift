import Vapor
import Fluent

struct UserAdminController {
    
    func renderPushView(_ req: Request,
                        subject: String? = nil,
                        message: String? = nil,
                        userId: String? = nil,
                        status: String? = nil) -> EventLoopFuture<View>
    {
        UserModel.query(on: req.db).all().mapEach(\.formFieldStringOption).flatMap {
            req.leaf.render(template: "User/Admin/Push", context: [
                "subject": .string(subject),
                "message": .string(message),
                "userId": .string(userId),
                "status": .string(status),
                "users": .array($0),
            ])
        }
    }
    
    func pushView(req: Request) throws -> EventLoopFuture<View> {
        renderPushView(req)
    }
    
    func push(req: Request) throws -> EventLoopFuture<View> {
        struct Input: Decodable {
            let subject: String
            let message: String
            let userId: String
        }
        let input = try req.content.decode(Input.self)
        guard !input.subject.isEmpty || !input.message.isEmpty else {
            return renderPushView(req, status: "Missing required field!")
        }
        guard let userId = UUID(uuidString: input.userId) else {
            throw Abort(.badRequest)
        }
        return UserModel
            .query(on: req.db)
            .filter(\.$id == userId)
            .with(\.$devices)
            .first()
            .unwrap(or: Abort(.notFound))
            .flatMap { user -> EventLoopFuture<Void> in
                let futures: [EventLoopFuture<Void>] = user.devices.map {
                    return req.apns.send(.init(title: input.subject, subtitle: input.message), to: $0.token)
                }
                return EventLoopFuture.andAllComplete(futures, on: req.eventLoop)
            }
            .flatMap {
                renderPushView(req, status: "Notification sent!")
            }
    }
}
