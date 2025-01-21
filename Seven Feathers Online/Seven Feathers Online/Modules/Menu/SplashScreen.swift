//
//  SplashScreen.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 20.01.2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    
                    Spacer()
                    
                }
                Spacer()
                
                
            }
            
            VStack {
                Spacer()
                
                Image(.logo1)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: scale
                    )
                    .onAppear {
                        scale = 0.8
                    }
                    .padding(.bottom, 20)
                
                Spacer()
            }
        }.background(
            Color.appSkyBlue
//            Image(.bg1)
//                .resizable()
//                .edgesIgnoringSafeArea(.all)
//                .scaledToFill()
            
        )
    }
}
#Preview {
    SplashScreen()
}
