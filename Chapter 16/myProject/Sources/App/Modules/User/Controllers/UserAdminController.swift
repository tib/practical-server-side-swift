import Vapor
import Fluent
import ViewKit

struct UserAdminController {
    
    func renderPushView(_ req: Request,
                title: String? = nil,
                message: String? = nil,
                userId: String? = nil,
                status: String? = nil) -> EventLoopFuture<View> {
        struct Context: Encodable {
            let title: String?
            var message: String?
            var userId: String?
            var status: String?
            var users: [FormFieldOption]
        }

        return UserModel.query(on: req.db).all()
            .mapEach { FormFieldOption(key: $0.id!.uuidString, label: $0.email) }
            .flatMap {
                let context = Context(title: title,
                                      message: message,
                                      userId: userId,
                                      status: status,
                                      users: $0)
                return req.view.render("User/Frontend/Push", context)
        }
    }

    func pushView(req: Request) throws -> EventLoopFuture<View> {
        self.renderPushView(req)
    }
    
    func push(req: Request) throws -> EventLoopFuture<View> {
        struct Input: Decodable {
            let title: String
            let message: String
            let userId: String
        }
        let input = try req.content.decode(Input.self)
        guard !input.title.isEmpty || !input.message.isEmpty else {
            return self.renderPushView(req, status: "Missing required field!")
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
                    return req.apns.send(.init(title: input.title, subtitle: input.message), to: $0.token)
                }
                return EventLoopFuture.andAllComplete(futures, on: req.eventLoop)
            }
            .flatMap {
                self.renderPushView(req, status: "Notification sent!")
            }
    }
}
