import Vapor
import Fluent

struct UserBadgeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let userBadges = routes.grouped("userBadges")
        userBadges.group(":userID") { userBadge in
            userBadge.get(use: readAllUserBadges)
            // userBadge.post(use: index)
        }
        // userBadges.group(":userBadgeID") { userBadge in
        //     userBadge.delete(use: delete)
        // }
    }

    @Sendable
    func readAllUserBadges(req: Request) async throws -> [UserBadge] {
        guard let userID = req.parameters.get("userID", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return try await UserBadge.query(on: req.db)
            .filter("user_id", .equal, userID)
            .all()
    }
}
