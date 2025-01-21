//
//  MenuView.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 21.01.2025.
//


import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showTrainig = false
    @State private var showGame = false
    @State private var showBestScore = false
    @State private var showHowToPlay = false
    @State private var showSettings = false
    
    @StateObject var user = User.shared
    @State private var timeRemaining: String = "24:00"
    @State private var timerActive: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //    @StateObject var achivementsVM = AchievementsViewModel()
    //    @StateObject var settingsVM = SettingsModel()
    @StateObject var teamVM = TeamViewModel()
    
    var body: some View {
        if teamVM.currentTeam == nil {
            TeamsView(viewModel: teamVM)
        } else {
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        
                        if geometry.size.width < geometry.size.height {
                            // Вертикальная ориентация
                            ZStack {
                                
                                VStack(spacing: 25) {
                                    
                                    
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Button {
                                                showTrainig = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 86, text: "Training", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                            }
                                            
                                            
                                            Button {
                                                
                                                showGame = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 86, text: "Competitive mode", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                            }
                                            
                                            Button {
                                                withAnimation {
                                                    showBestScore = true
                                                }
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 86, text: "Best score", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                            }
                                            
                                            Button {
                                                
                                                showHowToPlay = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 86, text: "How to play?", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                            }
                                            
                                            Button {
                                                showSettings = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 86, text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                            }
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                
                            }
                        } else {
                            ZStack {
                                
                                VStack {
                                    Spacer()
                                    
                                    VStack(spacing: 15) {
                                        
                                        HStack(spacing: 15) {
                                            Spacer()
                                            Button {
                                                showTrainig = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 70, text: "Training", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                            }
                                            
                                            Button {
                                                showGame = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 70, text: "Competitive mode", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                            }
                                            Spacer()
                                        }
                                        
                                        HStack(spacing: 15) {
                                            Spacer()
                                            Button {
                                                withAnimation {
                                                    showBestScore = true
                                                }
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 70, text: "Best score", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                            }
                                            
                                            Button {
                                                
                                                showHowToPlay = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 70, text: "How to play?", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                            }
                                            
                                            Spacer()
                                        }
                                        
                                        Button {
                                            showSettings = true
                                        } label: {
                                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 70, text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 60 : 32)
                                        }
                                        
                                        
                                    }
                                    Spacer()
                                }
                                
                                
                            }.padding(16)
                        }
                        Spacer()
                    }
                    
                    if showBestScore {
                        ZStack {
                            Color.black.opacity(0.5).ignoresSafeArea()
                            BestScoreView {
                                withAnimation {
                                    showBestScore = false
                                }
                            }
                        }
                    }
                }
                .background(
                    ZStack {
                        Color.appSkyBlue
                        
                        Image(.bg1)
                            .resizable()
                            .scaledToFill()
                    }.edgesIgnoringSafeArea(.all)
                    
                )
                //                .onAppear {
                //                    if settingsVM.musicEnabled {
                //                        MusicPlayer.shared.playBackgroundMusic()
                //                    }
                //                }
                //                .onChange(of: settingsVM.musicEnabled) { enabled in
                //                    if enabled {
                //                        MusicPlayer.shared.playBackgroundMusic()
                //                    } else {
                //                        MusicPlayer.shared.stopBackgroundMusic()
                //                    }
                //                }
                .fullScreenCover(isPresented: $showTrainig) {
                    //                    DailyRouletteView()
                }
                .fullScreenCover(isPresented: $showGame) {
                    //                    GamesView(viewModel: achivementsVM, settingsVM: settingsVM)
                }
                .fullScreenCover(isPresented: $showHowToPlay) {
                    //                    AchievementsView(viewModel: achivementsVM)
                }
                .fullScreenCover(isPresented: $showSettings) {
                    //                    SettingsView(settings: settingsVM)
                    
                }
                
            }
        }
        
    }
    
}

#Preview {
    MenuView()
}
