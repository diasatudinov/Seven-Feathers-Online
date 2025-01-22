//
//  TeamViewModel.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 20.01.2025.
//



import SwiftUI

class TeamViewModel: ObservableObject {
    @Published var teams: [Team] = [
        Team(icon: "avatar1", name: ""),
        Team(icon: "avatar2", name: ""),
        Team(icon: "avatar3", name: ""),
        Team(icon: "avatar4", name: ""),
        Team(icon: "avatar5", name: ""),
        Team(icon: "avatar6", name: "")
        
    ]
    
    @Published var currentTeam: Team? {
        didSet {
            saveTeam()
        }
    }
    
    init() {
        loadTeam()
    }
    private let userDefaultsTeamKey = "currentTeam"
    
    func saveTeam() {
        if let currentTeam = currentTeam {
            if let encodedData = try? JSONEncoder().encode(currentTeam) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsTeamKey)
            }
        }
    }
    
    func loadTeam() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsTeamKey),
           let loadedTeam = try? JSONDecoder().decode(Team.self, from: savedData) {
            currentTeam = loadedTeam
        } else {
            print("No saved data found")
        }
    }
    
    func randomTeam() -> Team? {
        let otherTeams = teams.filter { $0.name != currentTeam?.name }
        
        return otherTeams.randomElement()
    }
   
    func updateCurrentTeam(name: String, icon: String) {
        currentTeam = Team(icon: icon, name: name)
    }
}
