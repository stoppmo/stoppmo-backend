import Fluent

struct CreateUserBadge: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("user_badges")
            .id()
            .field("started_at", .date, .required)
            .field("claimed_at", .date, .required)
            .field("badge_id", .uuid, .references("badges", "id"))
            .field("user_id", .uuid, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("user_badges").delete()
    }
}