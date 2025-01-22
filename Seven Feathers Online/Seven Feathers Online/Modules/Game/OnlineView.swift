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
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        isPause = true
                    } label: {
                        ZStack {
                            Image(.pauseTL)
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
                        print(rndSeconds)
                        isSearcing = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(rndSeconds)) {
                            isSearcing = false
                            isOpponentFound = true
                            isStart = false
                        }
                    } label: {
                        TextBg(height: 60, text: "Player Search", textSize: 24)
                    }
                }
            }
            if isSearcing {
                VStack {
                    ZStack {
                        Color.black.opacity(0.5).ignoresSafeArea()
                        ProgressView()
                            .tint(.white)
                    }
                }
            }
            
            if isOpponentFound {
                HStack {
                    Spacer()
                    VStack {
                        
                        if let currentTeam = teamVM.currentTeam {
                            Image(currentTeam.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 140)
                            
                            Text(currentTeam.name)
                                .font(.custom(Alike.regular.rawValue, size: 24))
                                .foregroundStyle(.white)
                                .textCase(.uppercase)
                        }
                    }
                    
                    Text("VS")
                        .font(.custom(Alike.regular.rawValue, size: 36))
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .padding(50)
                    
                    VStack {
                        
                        if let randomTeam = teamVM.randomTeam() {
                            Image(randomTeam.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 140)
                            
                            Text(randomTeam.name)
                                .font(.custom(Alike.regular.rawValue, size: 24))
                                .foregroundStyle(.white)
                                .textCase(.uppercase)
                        }
                    }
                    Spacer()
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        isOpponentFound = false
                        isGame = true
                    }
                    
                }
            }
            
            if isGame {
                GameView(viewModel: GameViewModel(), settingsVM: settingsVM)
            }
            
            if isPause {
                ZStack {
                    
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    Image(.pauseBgTL)
                        .resizable()
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:195)
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
                Color.main.ignoresSafeArea()
                Image(.bgTL)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
            
        )
        
    }
}

#Preview {
    OnlineView(teamVM: TeamViewModel(), settingsVM: SettingsModel())
}
