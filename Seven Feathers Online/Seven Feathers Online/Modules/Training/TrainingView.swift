import SwiftUI
import AVFoundation

struct TrainingView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TrainingViewModel
    @ObservedObject var settingsVM: SettingsModel
    
    let columns = Array(repeating: GridItem(.flexible()), count: 4)

    @State private var isPause = false
    
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Button {
                        isPause = true
                        viewModel.pauseTimer()
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
            
            VStack {
                Spacer()
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
                
                
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(viewModel.tiles) { tile in
                        ZStack {
                            if tile.value != nil {
                                Image(.cell)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:66)
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
                }.frame(width: DeviceInfo.shared.deviceType == .pad ? 500 : 290)
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
                            viewModel.resumeTimer()
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
            
            if viewModel.isOver {
                ZStack {
                    
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    Image(.bestScoreTraining)
                        .resizable()
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 500: 253)
                    VStack(spacing: 0) {
                        
                        Spacer()
                        Text("Time")
                            .font(.custom(Alike.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                            .padding(.bottom, 5)
                        
                        Text(viewModel.scoreTime)
                            .font(.custom(Alike.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 5)
                            .background(
                                Rectangle()
                                    .foregroundStyle(.timeBg)
                                    .cornerRadius(20)
                                
                            )
                            .padding(.bottom, DeviceInfo.shared.deviceType == .pad ? 40:20)
                        Button {
                            viewModel.resetGame()
                            viewModel.isOver = false
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:38, text: "Retry", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                            
                        }.padding(.bottom, 10)
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:38, text: "Menu", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                            
                        }
                    }.padding(.bottom, DeviceInfo.shared.deviceType == .pad ? 40:15).frame(height: DeviceInfo.shared.deviceType == .pad ? 500 : 253)
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
    TrainingView(viewModel: TrainingViewModel(), settingsVM: SettingsModel())
}