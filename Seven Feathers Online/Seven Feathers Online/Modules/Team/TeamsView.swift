import SwiftUI

struct TeamsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TeamViewModel
    @State private var currentTab: Int = 0
    @State private var currentTeam: Team?
    @State private var nickname: String = ""
    var body: some View {
        GeometryReader { geometry in
            
            if geometry.size.width < geometry.size.height {
                ZStack {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ForEach(viewModel.teams.indices, id: \.self) { index in
                                
                                Button {
                                    currentTeam = viewModel.teams[index]
                                } label: {
                                    Image(viewModel.teams[index] == currentTeam ? viewModel.teams[index].selectedIcon : viewModel.teams[index].icon)
                                        .resizable()
                                        .foregroundColor(.black)
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 104 * 1.8 : 104)
                                }
                            }
                            .frame(width: DeviceInfo.shared.deviceType == .pad ? 160 : 80)
                            Spacer()
                        }.padding(.bottom)
                        
                        ZStack {
                            Image(.textFieldBg)
                                .resizable()
                                .scaledToFit()
                                
                            TextField("Nickname", text: $nickname)
                                .font(.custom(Fonts.regular.rawValue, size: 16))
                                .padding(.horizontal)
                                .foregroundStyle(.white)
                                
                        }.padding(.horizontal, 60).padding(.bottom, 50)
                        
                        
                        Button {
                            viewModel.currentTeam = currentTeam
                        } label: {
                            TextBg(height: 60, text: "PLAY", textSize: 20)
                        }
                        
                        Spacer()
                    }
                }
            } else {
                ZStack {
                    VStack {
                        Spacer()
                        HStack(spacing: 20) {
                            Spacer()
                            ForEach(viewModel.teams.indices, id: \.self) { index in
                                
                                Button {
                                    currentTeam = viewModel.teams[index]
                                } label: {
                                    Image(viewModel.teams[index] == currentTeam ? viewModel.teams[index].selectedIcon : viewModel.teams[index].icon)
                                        .resizable()
                                        .foregroundColor(.black)
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 104 * 1.8 : 104)
                                }
                            }
                            .frame(width: DeviceInfo.shared.deviceType == .pad ? 160 : 80)
                            Spacer()
                        }.padding(.bottom, 5)
                        
                        ZStack {
                            Image(.textFieldBg)
                                .resizable()
                                .scaledToFit()
                                
                            TextField("Nickname", text: $nickname)
                                .font(.custom(Fonts.regular.rawValue, size: 16))
                                .padding(.horizontal)
                                .foregroundStyle(.white)
                                
                        }.frame(width: 300).padding(.bottom, 50)
                        
                        
                        Button {
                            if let icon = currentTeam, !nickname.isEmpty {
                                viewModel.currentTeam = currentTeam
                            }
                        } label: {
                            TextBg(height: 60, text: "PLAY", textSize: 20)
                        }
                        
                    }
                }
            }
        }.background(
            Image(.appBg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
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