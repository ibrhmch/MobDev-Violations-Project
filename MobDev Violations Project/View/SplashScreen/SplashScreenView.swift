//
//  SplashScreenView.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/30/23.
//

import SwiftUI

struct SplashScreenView: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            withAnimation(
                .easeIn(duration: 1.2)) {
                    ContentView()
                }
        } else {
            
            VStack{
                VStack{
                    Image(systemName: "building.2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .font(.system(size: 80))
                        .foregroundColor(Color.primary.opacity(0.8))
                        .padding()
                    
                    Text("New York Building Violations")
                        .font(Font.custom("Menlo", size: 15))
                        .foregroundColor(Color.primary.opacity(0.8))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 2.0
                    }
                }
            }
//            .background(Color(red: 3/255, green: 38/255, blue:66/255))
            .preferredColorScheme(darkModeEnabled ? .dark : .light)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(
                        .easeIn(duration: 1.2)) {
                                self.isActive = true
                        }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
