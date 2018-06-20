import Vapor


final class UserController{
    func list(req: Request) throws ->Future<View>{
        return User.query(on: req).all().flatMap({ users in
            let data = ["userlist":users]
            return try req.view().render("CRUD", data)
        })
    }
    
    func createUser(req: Request) throws -> Future<Response>{
        return try req.content.decode(User.self).flatMap({ user in
            return user.save(on: req).map({ (user) in
                return req.redirect(to: "/users")
            })
        })
    }
    func update(req: Request) throws -> Future<Response>{
        return try req.parameters.next(User.self).flatMap({ user in
            return try req.content.decode(UserForm.self).flatMap({ userform in
                user.username = userform.username
                return user.save(on: req).map({ _ in
                    return req.redirect(to: "/users")
                })
            })
        })
    }
    func delete(req: Request) throws -> Future<Response>{
        return try req.parameters.next(User.self).flatMap({ user in
            user.delete(on: req).map({ _ in
                return req.redirect(to: "/users")
            })
        })
    }
}

struct UserForm: Content{
    var username: String
}
