//
//  TrainingViewModel.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 22.01.2025.
//


import SwiftUI
import Combine

class TrainingViewModel: ObservableObject {
    @Published var tiles: [Tile] = []
    @Published var isWin = false
    let gridSize = 3
    
    @Published var elapsedTime: String = "00:00"
    private var timer: AnyCancellable?
    private var startTime: Date?
    private var pausedTime: TimeInterval = 0
    private var isTimerRunning = false
    
    @AppStorage("lastTrainingScoreTime") var scoreTime: String = "00:00"
    
    init() {
        resetGame()
    }
    
    func resetGame() {
        // Stop the timer and reset time
        timer?.cancel()
        isTimerRunning = false
        elapsedTime = "00:00"
        pausedTime = 0
        // Generate numbers from 1 to 15 and add one empty cell
        var numbers = (1...7).map { $0 }
        numbers.append(contentsOf: [0, 0]) // Add two empty cells (represented as 0)
        numbers.shuffle()
        
        tiles = numbers.enumerated().map { index, value in
            Tile(id: index, value: value == 0 ? nil : value)
        }
    }
    
    
    func moveTile(at index: Int) {
        // Get the row and column of the tapped tile
        let tappedRow = index / gridSize
        let tappedCol = index % gridSize
        
        // Find the indices of the empty cells
        let emptyIndices = tiles.indices.filter { tiles[$0].value == nil }
        guard !emptyIndices.isEmpty else { return }
        
        // Check if the tapped tile is adjacent to any empty cell
        for emptyIndex in emptyIndices {
            let emptyRow = emptyIndex / gridSize
            let emptyCol = emptyIndex % gridSize
            
            let isAdjacent = (tappedRow == emptyRow && abs(tappedCol - emptyCol) == 1) ||
            (tappedCol == emptyCol && abs(tappedRow - emptyRow) == 1)
            
            if isAdjacent {
                // Swap the tapped tile with the empty cell
                tiles.swapAt(index, emptyIndex)
                
                // Start the timer on the first move
                if !isTimerRunning {
                    timer?.cancel()
                    startTimer()
                }
                
                // Check if the player has won
                if isGameCompleted() {
                    
                    stopTimer()
                    isWin = true
                    if isNewRecord(currentTime: elapsedTime, recordTime: scoreTime) {
                        scoreTime = elapsedTime
                    }
                }
            }
        }
    }
    
    func isGameCompleted() -> Bool {
        for i in 0..<7 {
            if tiles[i].value != i + 1 {
                return false
            }
        }
        return tiles[7].value == nil && tiles[8].value == nil
    }
    
    func progressBar() -> String {
        var count = 0

        // Проверяем элементы по парам
        for i in stride(from: 0, to: tiles.count - 1, by: 2) {
            // Проверяем, собраны ли текущая пара элементов в правильной последовательности
            let isFirstCorrect = tiles[i].value == i + 1
            let isSecondCorrect = i + 1 < tiles.count && tiles[i + 1].value == i + 2

            if isFirstCorrect && isSecondCorrect {
                count += 1
            } else {
                break // Прерываем проверку, если пара не собрана
            }
            
        }
        
        if count == 3 && tiles[6].value == 7 {
            count = 4
        }
        
        return "progress\(count)"
    }
    
    func startTimer() {
        isTimerRunning = true
        startTime = Date()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateElapsedTime()
            }
    }
    
    func pauseTimer() {
        guard isTimerRunning else { return }
        stopTimer()
        if let startTime = startTime {
            pausedTime += Date().timeIntervalSince(startTime)
        }
    }
    
    func resumeTimer() {
        guard !isTimerRunning else { return }
        startTimer()
    }
    
    func stopTimer() {
        timer?.cancel()
        isTimerRunning = false
    }
    
    private func updateElapsedTime() {
        guard let startTime = startTime else { return }
        let elapsed = Int(Date().timeIntervalSince(startTime) + pausedTime)
        let minutes = elapsed / 60
        let seconds = elapsed % 60
        elapsedTime = String(format: "%02d:%02d", minutes, seconds)
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
}
