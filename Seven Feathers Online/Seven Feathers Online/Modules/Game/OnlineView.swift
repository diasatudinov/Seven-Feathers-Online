//
//  OnlineView.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 22.01.2025.
//


import SwiftUI

struct OnlineView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var teamVM: TeamViewModel
    @ObservedObject var settingsVM: SettingsModel

    @State private var isPause = false
    @State private var isStart = true
    @State private var isSearcing = false
    @State private var isOpponentFound = false
    @State private var isGame = false
    
    @State private var names = ["John", "Jane", "Chris", "Alex", "Taylor", "Jordan", "Morgan", "Sydney", "Casey", "Jamie", "Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Martinez"]
    @State private var name = ""
    @State private var icon = "progress"
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        isPause = true
                    } label: {
                        ZStack {
                            Image(.pause)
                                .resizable()
                                .scaledToFit()
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                        
                    }
                    Spacer()
                    
                    
                }.padding([.top,.horizontal], 20)
                
                
                Spacer()
            }
            if isStart {
                VStack {
                    
                    Button {
                        let rndSeconds = Int.random(in: 3...5)
                        isStart = false
                        isSearcing = true
                        isOpponentFound = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(rndSeconds)) {
                            isSearcing = false
                            isStart = false
                        }
                    } label: {
                        TextBg(height: 60, text: "Player Search", textSize: 24)
                    }
                }
            }
            
            if isOpponentFound {
                ZStack {
                    Image(.compBg)
                        .resizable()
                        .scaledToFit()
                    
                    HStack(spacing: 0) {
                    Spacer()
                    VStack {
                        
                        if let currentTeam = teamVM.currentTeam {
                            Image(currentTeam.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                            
                            Text(currentTeam.name)
                                .font(.custom(Fonts.regular.rawValue, size: 32))
                                .foregroundStyle(.black)
                                .textCase(.uppercase)
                        }
                    }
                    
                    Text("VS")
                        .font(.custom(Fonts.regular.rawValue, size: 32))
                        .foregroundStyle(.black)
                        .textCase(.uppercase)
                        .padding(25)
                    
                    VStack {
                        
                        if let randomTeam = teamVM.randomTeam() {
                            if isSearcing {
                                ZStack {
                                    Image(.progress)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 60)
                                    ProgressView()
                                        .tint(.white)
                                }
                            } else {
                                Image(icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                                    .onAppear {
                                        name = generateRandomName()
                                        icon = randomTeam.icon
                                    }
                                    
                            }
                            Text(isSearcing ? "Find" : name)
                                .font(.custom(Fonts.regular.rawValue, size: 32))
                                .foregroundStyle(.black)
                                .textCase(.uppercase)
                                
                        }
                    }
                    Spacer()
                }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            isOpponentFound = false
                            isGame = true
                        }
                        
                    }
                }.frame(width: DeviceInfo.shared.deviceType == .pad ? 800: 430)
            }
            
            if isGame {
                if let randomTeam = teamVM.randomTeam() {
                    GameView(settingsVM: settingsVM, teamVM: teamVM, opponentIcon: icon, opponentName: name)
                }
            }
            
            if isPause {
                ZStack {
                    
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
//                    Image(.pauseBgTL)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:195)
                    VStack {
                        Spacer()
                        Button {
                            isPause = false
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:38, text: "Resume", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                            
                        }
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:38, text: "Menu", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                            
                        }
                    }.padding(.bottom, DeviceInfo.shared.deviceType == .pad ? 60:30)
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:195)
                }
            }
        }.background(
            ZStack {
                Color.appSkyBlue.ignoresSafeArea()
                Image(.bg1)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
            
        )
        
    }
    
    private func generateRandomName() -> String {
        // Combine random first and last names
        let name = names.randomElement()!
        self.name = name
        return name
    }
}

#Preview {
    OnlineView(teamVM: TeamViewModel(), settingsVM: SettingsModel())
}
