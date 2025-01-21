//
//  SettingsModel.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 21.01.2025.
//


import SwiftUI

class SettingsModel: ObservableObject {
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
}
