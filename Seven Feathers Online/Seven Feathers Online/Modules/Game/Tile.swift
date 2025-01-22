import Foundation

struct Tile: Identifiable {
    let id: Int
    let value: Int? // `nil` for the empty cell
}