import Vapor
import Fluent

final class User: Model, Content {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "email")
    var email: String

    @Field(key: "username")
    var username: String

    @Field(key: "passwordHash")
    var passwordHash: String

    init() { }

    init(id: UUID? = nil, email: String, username: String, passwordHash: String) {
        self.id = id
        self.email = email
        self.username = username
        self.passwordHash = passwordHash
    }
}

extension User: Sendable {}

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
            .id()
            .field("email", .string, .required)
            .field("username", .string, .required)
            .field("passwordHash", .string, .required)
            .unique(on: "email")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}
