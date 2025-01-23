//
//  Links.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 23.01.2025.
//


import SwiftUI

class Links {
    
    static let shared = Links()
    
    static let winStarData = "https://nordicinvest.pro/date"
    //"?page=test"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
