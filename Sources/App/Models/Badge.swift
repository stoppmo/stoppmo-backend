import Fluent
import Vapor
import struct Foundation.UUID

final class Badge: Model, Content, @unchecked Sendable {
    static let schema = "badges"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String

    @Field(key: "badge_image_url")
    var imageURL: String

    @Field(key: "unlock_streak_day")
    var unlockStreakDay: Int

    init() { }

    init(
        id: UUID? = nil,
        title: String,
        description: String,
        imageURL: String,
        unlockStreakDay: Int
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.unlockStreakDay = unlockStreakDay
    }
}
