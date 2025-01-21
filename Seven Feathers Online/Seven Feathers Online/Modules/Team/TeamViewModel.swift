
import SwiftUI

class TeamViewModel: ObservableObject {
    @Published var teams: [Team] = [
        Team(icon: "avatar1", selectedIcon: "avatar1S", name: ""),
        Team(icon: "avatar2", selectedIcon: "avatar2S", name: ""),
        Team(icon: "avatar3", selectedIcon: "avatar3S", name: ""),
        Team(icon: "avatar4", selectedIcon: "avatar4S", name: "")
        
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
}
