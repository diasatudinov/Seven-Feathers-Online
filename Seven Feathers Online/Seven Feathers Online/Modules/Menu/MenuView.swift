import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showDailyRoulette = false
    @State private var showGames = false
    @State private var showAchivements = false
    @State private var showSettings = false
    
    @StateObject var user = User.shared
    @State private var timeRemaining: String = "24:00"
    @State private var timerActive: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @StateObject var achivementsVM = AchievementsViewModel()
    @StateObject var settingsVM = SettingsModel()
    @StateObject var teamVM = TeamViewModel()
    
    var body: some View {
        if teamVM.currentTeam == nil {
            TeamsView(viewModel: teamVM)
        } else {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Spacer()
                    
                    if geometry.size.width < geometry.size.height {
                        // Вертикальная ориентация
                        ZStack {
                            
                            HStack {
                                Spacer()
                                HStack {
                                VStack(spacing: 25) {
                                    
                                    VStack {
                                        HStack {
                                            ZStack {
                                                Image(.moneyBg)
                                                    .resizable()
                                                    .scaledToFit()
                                                HStack {
                                                    Image(.coin)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .padding(.vertical, 5)
                                                    Text("\(user.coins)")
                                                        .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:25))
                                                        .foregroundStyle(.white)
                                                }
                                            }.frame(height: DeviceInfo.shared.deviceType == .pad ? 70:40)
                                            
                                            ZStack {
                                                Image(.moneyBg)
                                                    .resizable()
                                                    .scaledToFit()
                                                HStack {
                                                    Image(.line)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .padding(.vertical, 8)
                                                    Text("\(user.energy)")
                                                        .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:25))
                                                        .foregroundStyle(.white)
                                                    Button {
                                                        user.buyUserEnergy()
                                                    } label: {
                                                        Image(.plus)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .padding(5)
                                                    }
                                                }
                                            }.frame(height: DeviceInfo.shared.deviceType == .pad ? 70:40)
                                        }
                                        
                                        VStack {
                                            if let team = teamVM.currentTeam {
                                                Image(team.icon)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 200:100)
                                            }
                                            
                                            ZStack {
                                                ProgressView(value: Double(user.xp), total: 100)
                                                    .progressViewStyle(LinearProgressViewStyle())
                                                    .accentColor(Color.yellow)
                                                    .cornerRadius(10)
                                                    .padding(.horizontal, 1)
                                                    .background {
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .foregroundStyle(.white.opacity(0.45))
                                                    }
                                                    .scaleEffect(y: DeviceInfo.shared.deviceType == .pad ? 8:4.0, anchor: .center)
                                                Text("XP")
                                                    .foregroundStyle(.secondaryGold)
                                                    .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 25:16))
                                            }.frame(width: DeviceInfo.shared.deviceType == .pad ? 200:100)
                                        }
                                    }
                                    
                                    HStack {
                                        VStack {
                                            Button {
                                                showGames = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 86, text: "Games", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 22)
                                            }
                                            
                                            
                                            Button {
                                                
                                                showAchivements = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 86, text: "Achievements", textSize: DeviceInfo.shared.deviceType == .pad ? 32 : 20)
                                            }
                                            
                                            Button {
                                                showSettings = true
                                            } label: {
                                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 86, text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 22)
                                            }
                                        }
                                        
                                        DailyRouletteBoard(height: 200, btnText: timeRemaining != "00:00" ? "\(timeRemaining)" : "SPIN", btnPress: { showDailyRoulette = true })
                                    }
                                    
                                }
                            }
                                Spacer()
                            }
                            
                            
                            
                        }
                    } else {
                        ZStack {
                            
                            VStack {
                                HStack(alignment: .top) {
                                    DailyRouletteBoard(height: DeviceInfo.shared.deviceType == .pad ? 350:200, btnText: "SPIN", btnPress: {})
                                        .opacity(0)
                                    Spacer()
                                    VStack {
                                        HStack {
                                            ZStack {
                                                Image(.moneyBg)
                                                    .resizable()
                                                    .scaledToFit()
                                                HStack {
                                                    Image(.coin)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .padding(.vertical, 5)
                                                    Text("\(user.coins)")
                                                        .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:25))
                                                        .foregroundStyle(.white)
                                                }
                                            }.frame(height: DeviceInfo.shared.deviceType == .pad ? 70:40)
                                            
                                            ZStack(alignment: .leading) {
                                                Image(.moneyBg)
                                                    .resizable()
                                                    .scaledToFit()
                                                HStack {
                                                    Image(.line)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .padding(.vertical, 8)
                                                    Text("\(user.energy)")
                                                        .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:25))
                                                        .foregroundStyle(.white)
                                                    Button {
                                                        user.buyUserEnergy()
                                                    } label: {
                                                        Image(.plus)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .padding(5)
                                                    }
                                                }.padding(.horizontal)
                                            }.frame(height: DeviceInfo.shared.deviceType == .pad ? 70:40)
                                        }
                                        
                                        VStack {
                                            if let team = teamVM.currentTeam {
                                                Image(team.icon)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 200:100)
                                            }
                                        
                                            ZStack {
                                                ProgressView(value: Double(user.xp), total: 100)
                                                    .progressViewStyle(LinearProgressViewStyle())
                                                    .accentColor(Color.yellow)
                                                    .cornerRadius(10)
                                                    .padding(.horizontal, 1)
                                                    .background {
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .foregroundStyle(.white.opacity(0.45))
                                                    }
                                                    .scaleEffect(y: DeviceInfo.shared.deviceType == .pad ? 8:4.0, anchor: .center)
                                                Text("XP")
                                                    .foregroundStyle(.secondaryGold)
                                                    .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 25:16))
                                            }.frame(width: DeviceInfo.shared.deviceType == .pad ? 200:100)
                                        }
                                    }
                                    Spacer()
                                    DailyRouletteBoard(height: DeviceInfo.shared.deviceType == .pad ? 350:200, btnText: timeRemaining != "00:00" ? "\(timeRemaining)" : "SPIN", btnPress: { showDailyRoulette = true })
                                }
                                
                                VStack(spacing: 15) {
                                    
                                    HStack(spacing: 15) {
                                        Spacer()
                                        Button {
                                            showGames = true
                                        } label: {
                                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 70, text: "Games", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 20)
                                        }
                                        Spacer()
                                    }
                                    
                                    HStack(spacing: 15) {
                                        Spacer()
                                        Button {
                                            
                                            showAchivements = true
                                        } label: {
                                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 70, text: "Achievements", textSize: DeviceInfo.shared.deviceType == .pad ? 32 : 16)
                                        }
                                        
                                        Button {
                                            showSettings = true
                                        } label: {
                                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 140 : 70, text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 20)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    
                                }
                                Spacer()
                            }
                            
                            
                        }.padding(16)
                    }
                    Spacer()
                }
                .background(
                    Image(.appBg)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                    
                )
                .onAppear {
                    updateTimer()
                }
                .onReceive(timer) { _ in
                    updateTimer()
                }
                .onAppear {
                    if settingsVM.musicEnabled {
                        MusicPlayer.shared.playBackgroundMusic()
                    }
                }
                .onChange(of: settingsVM.musicEnabled) { enabled in
                    if enabled {
                        MusicPlayer.shared.playBackgroundMusic()
                    } else {
                        MusicPlayer.shared.stopBackgroundMusic()
                    }
                }
                .onChange(of: user.coins)  { newValue in
                    if newValue > 10000 {
                        achivementsVM.achievementOneDone()
                    }
                }
                .fullScreenCover(isPresented: $showDailyRoulette) {
                    DailyRouletteView()
                }
                .fullScreenCover(isPresented: $showGames) {
                    GamesView(viewModel: achivementsVM, settingsVM: settingsVM)
                }
                .fullScreenCover(isPresented: $showAchivements) {
                    AchievementsView(viewModel: achivementsVM)
                }
                .fullScreenCover(isPresented: $showSettings) {
                    SettingsView(settings: settingsVM)
                    
                }
                
            }
        }
        
    }
    
    private func updateTimer() {
        guard let lastPressDate = UserDefaults.standard.object(forKey: "LastPressDate") as? Date else {
            timeRemaining = "00:00"
            timerActive = false
            return
        }
        
        let now = Date()
        let totalDuration: TimeInterval = 5 * 60
        let elapsedTime = now.timeIntervalSince(lastPressDate)
        let remainingTime = totalDuration - elapsedTime
        
        if remainingTime <= 0 {
            timeRemaining = "00:00"
            timerActive = false
        } else {
            timerActive = true
            let hours =  (Int(remainingTime) % 3600) / 60
            let minutes =  (Int(remainingTime) % 60)
            timeRemaining = String(format: "%02d:%02d", hours, minutes)
        }
    }
    
}

#Preview {
    MenuView()
}