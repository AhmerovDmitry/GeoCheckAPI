import Vapor
import Fluent
import FluentSQLiteDriver

let app = Application(.development)
defer { app.shutdown() }

// 🔹 Настраиваем сервер, чтобы слушать внешние подключения
app.http.server.configuration.hostname = "0.0.0.0"
app.http.server.configuration.port = 8080

// 🔹 Подключаем базу SQLite
app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

// 🔹 Добавляем миграции
app.migrations.add(CreateUser())
try app.autoMigrate().wait()  // синхронно, для локального сервера

// 🔹 Маршруты
try routes(app)

// 🔹 Запуск сервера
try app.run()
