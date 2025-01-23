//
//  RootView.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 23.01.2025.
//


import SwiftUI

struct RootView: View {
    
    @State private var isLoading = true
    @State var toUp: Bool = true
    @AppStorage("vers") var verse: Int = 0
    
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    var body: some View {
        ZStack {
            if verse == 1 {
                WVWrap(urlString: Links.winStarData)
            } else {
                VStack {
                    if isLoading {
                        SplashScreen()
                            .onAppear {
                                startTimer()
                            }
                    } else {
                        MenuView()
                            .onAppear {
                                AppDelegate.orientationLock = .landscape
                                setOrientation(.landscapeRight)
                            }
                            .onDisappear {
                                AppDelegate.orientationLock = .all
                            }
                            
                    }
                }
            }
        }
        .onAppear {
            updateIfNeeded()
        }
    }
    
    func updateIfNeeded() {
        if Links.shared.finalURL == nil {
            Task {
                if await !Resolver.checking() {
                    verse = 1
                    toUp = false
                    
                } else {
                    verse = 0
                    toUp = true
                }
            }
        } else {
            isLoading = false
        }
        
        
    }
    
    func setOrientation(_ orientation: UIInterfaceOrientation) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let selector = NSSelectorFromString("setInterfaceOrientation:")
            if let responder = windowScene.value(forKey: "keyWindow") as? UIResponder, responder.responds(to: selector) {
                responder.perform(selector, with: orientation.rawValue)
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 1 {
                progress += 0.01
            } else {
                isLoading = false
                timer.invalidate()
            }
        }
    }
}

#Preview {
    RootView()
}
