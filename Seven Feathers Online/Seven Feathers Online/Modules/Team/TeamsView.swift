//
//  TeamsView.swift
//  Seven Feathers Online
//
//  Created by Dias Atudinov on 20.01.2025.
//


import SwiftUI

struct TeamsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TeamViewModel
    @State private var currentTab: Int = 0
    @State private var currentTeam: Team?
    @State private var nickname: String = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ZStack {
                            Image(.regBg)
                                .resizable()
                                .scaledToFit()
                            
                            VStack {
                                Spacer()
                                Text("Name")
                                    .font(.custom(Fonts.regular.rawValue, size: 36))
                                    .foregroundStyle(.white)
                                    .textCase(.uppercase)
                                    .frame(height: 30)
                                
                                ZStack {
                                    Image(.textFieldBg)
                                        .resizable()
                                        .scaledToFit()
                                        
                                    
                                    TextField("Nickname", text: $nickname)
                                        .font(.custom(Fonts.regular.rawValue, size: 16))
                                        .bold()
                                        .padding(.horizontal)
                                        .foregroundStyle(.white)
                                    
                                    
                                }.padding(.horizontal, 30)
                                
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(viewModel.teams.indices, id: \.self) { index in
                                        
                                        Button {
                                            currentTeam = viewModel.teams[index]
                                        } label: {
                                            Image(viewModel.teams[index].icon)
                                                .resizable()
                                                .foregroundColor(.black)
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 39 * 1.8 : 39)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke(currentTeam == viewModel.teams[index] ? Color.green : Color.clear, lineWidth: 4)
                                                )
                                        }
                                        
                                    }
                                }.padding(.bottom).padding(.horizontal, 35)
                        
                                Spacer()
                            }
                        }.frame(width: 213, height: 250)
                        
                        Button {
                            if let team = currentTeam, !nickname.isEmpty {
                                viewModel.currentTeam = Team(icon: team.icon, name: nickname)
                            }
                        } label: {
                            ZStack {
                                Image(currentTeam != nil && !nickname.isEmpty ? .startBtnBgOn : .startBtnBgOff)
                                    .resizable()
                                    .scaledToFit()
                                Text("Get Started")
                                    .font(.custom(Fonts.regular.rawValue, size: 36))
                                    .foregroundStyle(.black)
                                    .textCase(.uppercase)
                            }
                            .frame(height: 80)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            
        }.background(
            ZStack {
                Color.appSkyBlue
                
                Image(.bg1)
                    .resizable()
                    .scaledToFill()
            }.edgesIgnoringSafeArea(.all)
            
        )
    }
    
    @ViewBuilder func achivementView(image: String, header: String, imageHeight: CGFloat, team: Team) -> some View {
        
        
        HStack(spacing: 20) {
            
            VStack(alignment: .center, spacing: 10) {
                
                
                
                
                Text(header)
                    .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .textCase(.uppercase)
                    .padding(.bottom, 8)
                
            }
            
        }
    }
}

#Preview {
    TeamsView(viewModel: TeamViewModel())
}
