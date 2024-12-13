import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        app.logger.info(Logger.Message(stringLiteral: "Hello, world!"))
        return "Hello, Vapor|"
    }

    try app.register(collection: UserController())
    try app.register(collection: BadgeController())
    try app.register(collection: UserBadgeController())
}