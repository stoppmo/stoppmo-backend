import Fluent
import Vapor

// A controller for managing all badges the application offers.
// To handle badges of a specific user, go to `UserBadgeController`.
struct BadgeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let badges = routes.grouped("badges")
        badges.get(use: self.index)
        // TODO: Protect this route for admin users only.
        badges.post(use: self.add)
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
}
