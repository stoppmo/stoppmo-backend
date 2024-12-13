import Fluent

struct CreateBadge: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("badges")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("imageURL", .string, .required)
            .field("unlockStreakDay", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("badges").delete()
    }
}