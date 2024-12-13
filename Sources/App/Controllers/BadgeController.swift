import Fluent
import Vapor

// A controller for managing all badges the application has.
// To handle badges of a specific user, go to `UserBadgeController`.
struct BadgeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let badges = routes.grouped("badges")
        badges.get(use: self.index)
        // TODO: Protect this route for admin users only.
        badges.post(use: self.add)
        badges.get(":id", use: self.read)
    }

    @Sendable
    func index(req: Request) async throws -> [Badge] {
        try await Badge.query(on: req.db).all()
    }

    @Sendable
    func add(req: Request) async throws -> Badge {
        let badge = try req.content.decode(Badge.self)
        try await badge.save(on: req.db)
        return badge
    }

    @Sendable
    func read(req: Request) throws -> EventLoopFuture<Badge> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let badge = Badge.find(id, on: req.db).unwrap(or: Abort(.notFound))
        return badge
    }
}
