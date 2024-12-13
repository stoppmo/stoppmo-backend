import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        // TODO: make sure to not expose private information that should not be exposed.
        users.get(use: self.index)
        // TODO: limit the amount of accounts created per device, and per ip address.
        // TODO: protect route so that user cannot just add false data to their profile, like credits, subscriptions, badges, etc.
        users.post(use: self.add)
        users.get(":id", use: self.read)
    }

    @Sendable
    func index(req: Request) async throws -> [User] {
        try await User.query(on: req.db).all()
    }

    @Sendable
    func add(req: Request) async throws -> User {
        let user = try req.content.decode(User.self)
        try await user.create(on: req.db)
        return user
    }

    @Sendable
    func read(req: Request) throws -> EventLoopFuture<User> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        print("id: \(id)")
        let user = User.find(id, on: req.db).unwrap(or: Abort(.notFound))
        return user
    }
}
