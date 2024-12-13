import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: self.index)
        users.post(use: self.add)
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
}
