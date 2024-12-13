import Vapor
import Fluent

struct UserBadgeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        print("In user badge controller.")
    }
}
