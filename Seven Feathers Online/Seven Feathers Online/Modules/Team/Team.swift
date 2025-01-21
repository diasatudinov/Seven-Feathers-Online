import Foundation

struct Team : Identifiable, Equatable, Codable, Hashable {
    let id = UUID()
    let icon: String
    let selectedIcon: String
    let name: String
}