//
//  BestScoreView.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 21.01.2025.
//

import SwiftUI

struct BestScoreView: View {
    var trainingTime: String
    var gameTime: String
    var xBtnTap: () -> ()
    var body: some View {
        ZStack {
            Image(.regBg)
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 20) {
                Spacer()
                VStack(spacing: 20) {
                    Text("Training")
                        .font(.custom(Fonts.regular.rawValue, size: 24))
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .frame(height: 20)
                    ZStack {
                        Image(.textFieldBg)
                            .resizable()
                            .scaledToFit()
                            .scaledToFit()
                            .frame(height: 34)
                        Text(trainingTime)
                            .font(.custom(Fonts.regular.rawValue, size: 16))
                            .foregroundStyle(.white)
                    }
                }.padding(.horizontal)
                
                VStack(spacing: 20) {
                    Text("Competitive mode")
                        .font(.custom(Fonts.regular.rawValue, size: 24))
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .frame(height: 20)
                    
                    ZStack {
                        Image(.textFieldBg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 34)
                        
                        Text(gameTime)
                            .font(.custom(Fonts.regular.rawValue, size: 16))
                            .foregroundStyle(.white)
                    }
                }.padding(.horizontal)
                Spacer()
            }
            
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    Button {
                        xBtnTap()
                    } label: {
                        Image(.xbtn)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 44)
                    }
                }
                Spacer()
                
            }.padding(-10)
        }.frame(width: 213, height: 243)
    }
}

#Preview {
    BestScoreView(trainingTime: "00:30", gameTime: "01:30", xBtnTap: {})
}
