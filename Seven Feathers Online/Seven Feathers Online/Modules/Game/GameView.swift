//
//  GameView.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 22.01.2025.
//


import SwiftUI
import AVFoundation

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = GameViewModel()
    @StateObject var viewModel2 = GameViewModel()
    @StateObject var viewModel3 = GameViewModel()
    @StateObject var viewModel4 = GameViewModel()
    @ObservedObject var settingsVM: SettingsModel
    @ObservedObject var teamVM: TeamViewModel

    @State private var unlockedBoards = [true, false, false, false] // Состояния разблокировки досок
    @State private var board1Finish = false
    @State private var board2Finish = false
    @State private var board3Finish = false
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    @State private var isPause = false
    @State private var audioPlayer: AVAudioPlayer?
    
    @State var opponentIcon: String
    @State var opponentName: String
    
    @State private var stars: [Int] = [] // Array to track added stars
    @State private var timer: Timer? // Timer to add stars
    @State private var isRunning = false
    @State private var youLose = false
    var body: some View {
        ZStack {
            
            VStack {
                ZStack {
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
                        
                        ZStack {
                            Image(.timeBg)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            Text(viewModel.elapsedTime)
                                .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                .foregroundStyle(.white)
                                .textCase(.uppercase)
                                .padding(10)
                                
                        }.frame(width: DeviceInfo.shared.deviceType == .pad ? 400:200)
                    }.padding([.top,.horizontal], 20)
                    
                    HStack {
                        
                        HStack {
                            
                            Image(opponentIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                            
                            Text(opponentName)
                                .font(.custom(Fonts.regular.rawValue, size: 32))
                                .foregroundStyle(.black)
                                .textCase(.uppercase)
                            
                            ForEach(stars, id: \.self) { star in
                                Image(.star)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 25)
                                    .foregroundColor(.yellow)
                            }
                        }
                        
                    }.padding([.top,.horizontal], 20)
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    //MARK: YOU
                    boardView(for: viewModel, isLocked: !unlockedBoards[0], id: 0, finished: board1Finish)
                    boardView(for: viewModel2, isLocked: !unlockedBoards[1], id: 1, finished: board2Finish)
                    boardView(for: viewModel3, isLocked: !unlockedBoards[2], id: 2, finished: board3Finish)
                    boardView(for: viewModel4, isLocked: !unlockedBoards[3], id: 3, finished: false)
                    
                    
                }.padding(.horizontal)
                Spacer()
            }
            
            if viewModel.isGameOver {
                ZStack {
                    
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    Image(youLose ? .loseBg:.winBg)
                        .resizable()
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 600:338)
                    VStack(spacing: 20) {
                        Spacer()
                        VStack(spacing: 4) {
                            if youLose  {
                                HStack {
                                    Image(opponentIcon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 40)
                                    Text(opponentName)
                                        .font(.custom(Fonts.regular.rawValue, size: 24))
                                        .foregroundStyle(.black)
                                }
                            } else {
                                if let team = teamVM.currentTeam {
                                    HStack {
                                        Image(team.icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 40)
                                        Text(team.name)
                                            .font(.custom(Fonts.regular.rawValue, size: 24))
                                            .foregroundStyle(.black)
                                    }
                                }
                            }
                            ZStack {
                                Image(.timeBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                Text(viewModel.elapsedTime)
                                    .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                    .foregroundStyle(.white)
                                    .textCase(.uppercase)
                                
                            }
                        }
                        
                        VStack(spacing: 7) {
                            Button {
                                viewModel.isGameOver = false
                                viewModel.resetGame()
                                resetGame2()
                                
                            } label: {
                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:50, text: "Retry", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                                
                            }
                            
                            Button {
                                viewModel.resetGame()
                                resetGame2()
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:50, text: "Menu", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                                
                            }
                        }
                    }.padding(.bottom, DeviceInfo.shared.deviceType == .pad ? 60:30)
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:300)
                }
            }
            
            if isPause {
                ZStack {
                    
                    Color.black.opacity(0.5).ignoresSafeArea()
                    
                    Image(.pauseBg)
                        .resizable()
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 450:250)
                    VStack(spacing: 7) {
                        Spacer()
                        Button {
                            isPause = false
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:60, text: "Resume", textSize: DeviceInfo.shared.deviceType == .pad ? 48:32)
                            
                        }
                        
                        Button {
                            viewModel.resetGame()
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80:60, text: "Menu", textSize: DeviceInfo.shared.deviceType == .pad ? 48:32)
                            
                        }
                    }
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 400:195)
                }
            }
        }
        .background(
            ZStack {
                Color.appSkyBlue.ignoresSafeArea()
                Image(.bg1)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
            
        )
        .onAppear {
            startAddingStars()
        }
    }
    
    private func isNewRecord(currentTime: String, recordTime: String) -> Bool {
        let currentComponents = currentTime.split(separator: ":").compactMap { Int($0) }
        let recordComponents = recordTime.split(separator: ":").compactMap { Int($0) }

        guard currentComponents.count == 2, recordComponents.count == 2 else {
            return false
        }

        let currentSeconds = currentComponents[0] * 60 + currentComponents[1]
        let recordSeconds = recordComponents[0] * 60 + recordComponents[1]

        return currentSeconds < recordSeconds || recordTime == "00:00"
    }
    
    private func resetGame2() {
        unlockedBoards = [true, false, false, false]
        board1Finish = false
        board2Finish = false
        board3Finish = false
    }
    
    @ViewBuilder
    private func boardView(for viewModel: GameViewModel, isLocked: Bool, id: Int, finished: Bool) -> some View {
            ZStack {
                if isLocked {
                    VStack {
                        Spacer()
                        Image(.check)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .opacity(0)
                        ZStack {
                            Color.gray.opacity(0.5)
                                .cornerRadius(10)
                            Text("Locked")
                                .font(.headline)
                                .foregroundColor(.white)
                        }.frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.width * 0.23)
                        Spacer()
                    }
                } else {
                    VStack {
                        Spacer()
                        if finished {
                            Image(.check)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } else {
                            Image(.check)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .opacity(0)
                        }
                        
                        ZStack {
                            Image(.deskBgImg)
                                .resizable()
                                .scaledToFit()
                            Color.deskBg
                                .frame(width: UIScreen.main.bounds.width * 0.197, height: UIScreen.main.bounds.width * 0.197)
                            LazyVGrid(columns: columns, spacing: 0) {
                                ForEach(viewModel.tiles) { tile in
                                    ZStack {
                                        if tile.value != nil {
                                            Image(.cell)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:  UIScreen.main.bounds.width * 0.07,height: UIScreen.main.bounds.width * 0.07)
                                        }
                                        
                                        if let value = tile.value {
                                            Text("\(value)")
                                                .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48 : 24))
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .onTapGesture {
                                        if let index = viewModel.tiles.firstIndex(where: { $0.id == tile.id }) {
                                            withAnimation {
                                                viewModel.moveTile(at: index)
                                            }
                                            if settingsVM.soundEnabled {
                                                playSound(named: "move")
                                                
                                            }
                                            checkWin(for: viewModel, id: id)
                                        }
                                    }
                                }
                            }.frame(width: UIScreen.main.bounds.width * 0.197, height: UIScreen.main.bounds.width * 0.197)
                        }.frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.width * 0.23)
                            .disabled(finished)
                        Spacer()
                    }

                }
            }
            
        }
    
    private func checkWin(for viewModel: GameViewModel, id: Int) {
            if viewModel.isGameCompleted() {
                withAnimation {
                    unlockNextBoard(after: id)
                }
            }
        }
    
    private func unlockNextBoard(after completedViewModelId: Int) {
        
            if completedViewModelId == 0 {
                unlockedBoards[1] = true
                board1Finish = true
            } else if completedViewModelId == 1 {
                unlockedBoards[2] = true
                board2Finish = true

            } else if completedViewModelId == 2 {
                unlockedBoards[3] = true
                board3Finish = true
            } else if completedViewModelId == 3 {
                if isNewRecord(currentTime: viewModel.elapsedTime, recordTime: viewModel.scoreTime) {
                    viewModel.scoreTime = viewModel.elapsedTime
                }
                viewModel.isGameOver = true
                viewModel.stopTimer()
            }
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
    
    func startAddingStars() {
        isRunning = true
        addStarWithRandomDelay()
    }
    
    func stopAddingStars() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func addStarWithRandomDelay() {
        guard stars.count < 4 else { // Stop adding if max stars reached
            stopAddingStars()
            viewModel.isGameOver = true
            youLose = true
            viewModel.stopTimer()
            
            return
        }
        
        // Generate a random time interval between 20 and 50 seconds
        let randomDelay = TimeInterval(Int.random(in: 20...50))
        
        timer = Timer.scheduledTimer(withTimeInterval: randomDelay, repeats: false) { _ in
            stars.append(stars.count + 1) // Add a star
            addStarWithRandomDelay() // Schedule the next star
        }
    }
}

#Preview {
    GameView(settingsVM: SettingsModel(), teamVM: TeamViewModel(), opponentIcon: "avatar1", opponentName: "Dias")
}
