import Foundation

struct User: Codable, Equatable {
    let id: String
    let firstName: String
}

/// A tiny session store: sign in, sign out, restore on launch.
final class SessionStore {
    static let shared = SessionStore()
    private let key = "session.user"
    private(set) var currentUser: User?

    func restore() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        currentUser = try? JSONDecoder().decode(User.self, from: data)
    }

    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let user = User(id: "usr_\(abs(email.hashValue))", firstName: email.components(separatedBy: "@").first ?? "friend")
            self.currentUser = user
            UserDefaults.standard.set(try? JSONEncoder().encode(user), forKey: self.key)
            completion(.success(user))
        }
    }

    func signOut() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: key)
    }
}
