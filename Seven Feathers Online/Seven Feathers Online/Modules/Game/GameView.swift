import SwiftUI
import AVFoundation

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: GameViewModel
    @ObservedObject var settingsVM: SettingsModel
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    @State private var isPause = false
    @State private var audioPlayer: AVAudioPlayer?
    var body: some View {
        ZStack {
            
            VStack {
                ZStack {
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
                    
                    HStack {
                        Text(viewModel.elapsedTime)
                        .font(.custom(Alike.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                            .padding(10)
                            .frame(width: DeviceInfo.shared.deviceType == .pad ? 400:200)
                            .background(
                                Rectangle()
                                    .cornerRadius(5)
                                    .foregroundStyle(.bgMain)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(lineWidth: 2).foregroundStyle(.mainRed)
                                    )
                            )
                    }.padding([.top,.horizontal], 20)
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    //MARK: YOU
                    VStack(spacing: 10) {
                        Spacer()
                        Text("You")
                            .font(.custom(Alike.regular.rawValue, size: 32))
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                        LazyVGrid(columns: columns, spacing: 4) {
                            ForEach(viewModel.tiles) { tile in
                                ZStack {
                                    if tile.value != nil {
                                        Image(.cell)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 110:55)
                                    }
                                    
                                    if let value = tile.value {
                                        Text("\(value)")
                                            .font(.custom(Alike.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48 : 24))
                                            .foregroundColor(.black)
                                    }
                                }
                                .onTapGesture {
                                    if let index = viewModel.tiles.firstIndex(where: { $0.id == tile.id }) {
                                        viewModel.moveTile(at: index)
                                        if settingsVM.soundEnabled {
                                            playSound(named: "move")
                                            
                                        }
                                    }
                                }
                            }
                        }.frame(width: DeviceInfo.shared.deviceType == .pad ? 470 : 235)
                            .padding(15)
                            .background(
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundStyle(.bgMain)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2).foregroundStyle(.mainRed)
                                    )
                            )
                    }
                    Spacer()
                    //MARK: Opponent
                    
                    VStack(spacing: 10) {
                        Spacer()
                        Text("Opponent")
                            .font(.custom(Alike.regular.rawValue, size: 32))
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                        LazyVGrid(columns: columns, spacing: 4) {
                            ForEach(viewModel.opponentsTiles) { tile in
                                ZStack {
                                    if tile.value != nil {
                                        Image(.cell)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 110:55)
                                    }
                                    
                                    if let value = tile.value {
                                        Text("\(value)")
                                            .font(.custom(Alike.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48 : 24))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }.frame(width: DeviceInfo.shared.deviceType == .pad ? 470 : 235)
                            .padding(15)
                            .background(
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundStyle(.bgMain)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2).foregroundStyle(.mainRed)
                                    )
                            )
                    }
                }
                Spacer()
            }
            
            if viewModel.isWin {
                ZStack {
                    
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    Image(.youWinBg)
                        .resizable()
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:195)
                    VStack {
                        Spacer()
                        Button {
                            viewModel.isWin = false
                            viewModel.resetGame()
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:38, text: "New game", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                            
                        }
                        
                        Button {
                            viewModel.resetGame()
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:38, text: "Menu", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                            
                        }
                    }.padding(.bottom, DeviceInfo.shared.deviceType == .pad ? 60:30)
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:195)
                }
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
                            viewModel.resetGame()
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:38, text: "Menu", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                            
                        }
                    }.padding(.bottom, DeviceInfo.shared.deviceType == .pad ? 60:30)
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:195)
                }
            }
        }
        .background(
            ZStack {
                Color.main.ignoresSafeArea()
                Image(.bgTL)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
            
        )
    }
    
    func playSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel(), settingsVM: SettingsModel())
}
