import Fluent

struct CreateBadge: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("badges")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("image_url", .string, .required)
            .field("unlock_streak_day", .int, .required)
            // .field("user_id", .uuid, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("badges").delete()
    }
}