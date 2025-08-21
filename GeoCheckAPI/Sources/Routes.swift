import Vapor
import Fluent

func routes(_ app: Application) throws {
    app.get("hello") { req in
        "👋 Hello from GeoCheckAPI!"
    }

    app.post("auth", "register") { req async throws -> LoginResponse in
        let data = try req.content.decode(RegisterRequest.self)
        let hash = try Bcrypt.hash(data.password)
        let user = User(email: data.email, username: data.username, passwordHash: hash)
        try await user.save(on: req.db)

        return LoginResponse(id: user.id!, email: user.email, username: user.username, token: "mock-token-123")
    }

    app.post("auth", "login") { req async throws -> LoginResponse in
        let data = try req.content.decode(LoginRequest.self)

        guard let user = try await User.query(on: req.db)
            .filter(\.$email == data.email)
            .first() else {
            throw Abort(.unauthorized, reason: "Пользователь не найден")
        }

        guard try Bcrypt.verify(data.password, created: user.passwordHash) else {
            throw Abort(.unauthorized, reason: "Неверный пароль")
        }

        return LoginResponse(id: user.id!, email: user.email, username: user.username, token: "mock-token-123")
    }
}
