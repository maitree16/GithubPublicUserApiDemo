// MARK: - Welcome
class Repo_Model: Codable {
    let id: Int
    let name, fullName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
    }

    init(id: Int, name: String, fullName: String) {
        self.id = id
        self.name = name
        self.fullName = fullName
    }
}
