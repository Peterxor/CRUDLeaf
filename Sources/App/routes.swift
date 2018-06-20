import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("users", use: UserController().list)
    router.post("users", use: UserController().createUser)
    router.post("users", "update", User.parameter, use: UserController().update)
    router.post("users", User.parameter, "delete", use: UserController().delete)
}
