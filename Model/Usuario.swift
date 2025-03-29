import Foundation

struct Usuario: Identifiable, Codable {
    var id: UUID = UUID()
    let nombre: String
    let email: String
}

