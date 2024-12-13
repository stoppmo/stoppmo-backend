import Fluent
import Vapor
import struct Foundation.UUID

// UserBadge is for all the badges a user has unlocked so far.
final class UserBadge: Model, Content, @unchecked Sendable {
    static let schema = "user_badges"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "started_at")
    var startedAt: Date

    @Field(key: "claimed_at")
    var claimedAt: Date

    @Parent(key: "badge_id")
    var badge: Badge

    @Parent(key: "user_id")
    var user: User

    init() { }

    init(
        startedAt: Date,
        claimedAt: Date,
        badgeID: UUID,
        userID: UUID
    ) {
        self.startedAt = startedAt
        self.claimedAt = claimedAt
        self.$badge.id = badgeID
        self.$user.id = userID
    }
}
