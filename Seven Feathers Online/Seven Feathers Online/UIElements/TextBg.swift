//
//  TextBg.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 20.01.2025.
//


import SwiftUI

struct TextBg: View {
    var height: CGFloat
    var text: String
    var textSize: CGFloat
    var body: some View {
        ZStack {
            Image(.textBg)
                .resizable()
                .scaledToFit()
                .frame(height: height)
            Text(text)
                .font(.custom(Fonts.regular.rawValue, size: textSize))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    TextBg(height: 100, text: "Select", textSize: 32)
}
