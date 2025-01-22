//
//  Tile.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 22.01.2025.
//


import Foundation

struct Tile: Identifiable, Hashable {
    let id: Int
    let value: Int? // `nil` for the empty cell
}
