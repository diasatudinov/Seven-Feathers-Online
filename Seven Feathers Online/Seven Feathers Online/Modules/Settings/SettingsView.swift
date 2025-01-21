import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings: SettingsModel
    var body: some View {
        ZStack {
            
            VStack(spacing: 0)  {
                ZStack {
                    HStack {
                        Spacer()
                        
                        Text("Settings")
                            .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 60:35))
                            .foregroundStyle(.yellow)
                            .textCase(.uppercase)
                        
                        Spacer()
                    }
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Image(.backBtn)
                                    .resizable()
                                    .scaledToFit()
                                
                            }.frame(height: 50)
                            
                        }
                        Spacer()
                    }.padding([.leading, .top])
                }
                Spacer()
                VStack(spacing: 16) {

                    VStack(spacing: 10)  {
                        
                        Text("music")
                            .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 60:30))
                            .foregroundStyle(.gold)
                        
                        HStack(spacing: 16) {
                            Button {
                                settings.musicEnabled = true
                            } label: {
                                if settings.musicEnabled {
                                    Image(.onS)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:60)
                                } else {
                                    Image(.on)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:60)
                                }
                            }
                            
                            Button {
                                settings.musicEnabled = false
                            } label: {
                                if settings.musicEnabled {
                                    Image(.off)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:60)
                                } else {
                                    Image(.offS)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:60)
                                }
                            }
                            
                        }
                    }
                   
                    VStack(spacing: 10)  {
                        
                        Text("vibration")
                            .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 60 :30))
                            .foregroundStyle(.gold)
                        
                        HStack(spacing: 16) {
                            Button {
                                settings.soundEnabled = true
                            } label: {
                                if settings.soundEnabled {
                                    Image(.onS)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:60)
                                } else {
                                    Image(.on)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:60)
                                }
                            }
                            
                            Button {
                                settings.soundEnabled = false
                            } label: {
                                if settings.soundEnabled {
                                    Image(.off)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:60)
                                } else {
                                    Image(.offS)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:60)
                                }
                            }
                            
                        }
                    }
                    
                    Button {
                        rateUs()
                    } label: {
                        
                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 150:80, text: "RATE US", textSize: DeviceInfo.shared.deviceType == .pad ? 40:20)
                    }
                }
                
                Spacer()
            }
        }.background(
            Image(.appBg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
    
    func rateUs() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    SettingsView(settings: SettingsModel())
}
