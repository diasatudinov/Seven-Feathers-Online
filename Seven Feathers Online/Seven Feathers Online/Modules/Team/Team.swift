//
//  Team.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 20.01.2025.
//


import Foundation

struct Team : Identifiable, Equatable, Codable, Hashable {
    let id = UUID()
    let icon: String
    let name: String
}
