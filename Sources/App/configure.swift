import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Have the production connection string in ".env.production" and the development database connection
    // string in ".env.development".
    let databaseConnectionString = Environment.get("DATABASE_CONNECTION_STRING") ?? "conn_string_not_found"
    app.logger.info("Database connection string: \(databaseConnectionString)")
    try app.databases.use(
        .postgres(url: databaseConnectionString),
        as: .psql
    )

    // Add all migrations to database
    app.migrations.add(CreateUser())
    app.migrations.add(CreateBadge())

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
