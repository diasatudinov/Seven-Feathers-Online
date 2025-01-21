//
//  ContentView.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 20.01.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
          
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            
            
        }
        .background(
            ZStack {
                Color.appSkyBlue
                Image(.bg1)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }.ignoresSafeArea()
        )
    }
}

#Preview {
    ContentView()
}
