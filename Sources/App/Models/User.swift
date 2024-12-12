import Fluent
import Foundation

final class User: Model, @unchecked Sendable {
    static let schema: String = "users"

    @ID(key: .id)
    var id : UUID?

    @Field(key: "first_name")
    var firstName: String

    @Field(key: "last_name")
    var lastName: String

    @Field(key: "username")
    var username: String

    @Field(key: "email")
    var email: String

    @Field(key: "password")
    var password: String

    @Field(key: "profile_picture_url")
    var profilePictureURL: String

    @Field(key: "bio")
    var bio: String

    @Field(key: "phone_number")
    var phoneNumber: String

    @Field(key: "date_of_birth")
    var dateOfBirth: Date

    @Field(key: "created_at")
    var createdAt: Date

    @Field(key: "updated_at")
    var updatedAt: Date?

    init() { }

    init(
        id: UUID? = nil,
        firstName: String,
        lastName: String,
        username: String,
        email: String,
        password: String,
        profilePictureURL: String,
        bio: String,
        phoneNumber: String,
        dateOfBirth: Date,
        createdAt: Date,
        updatedAt: Date?
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.email = email
        self.password = password
        self.profilePictureURL = profilePictureURL
        self.bio = bio
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}