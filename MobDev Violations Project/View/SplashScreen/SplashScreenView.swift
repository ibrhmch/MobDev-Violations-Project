//
//  SplashScreenView.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/30/23.
//

import SwiftUI

struct SplashScreenView: View {
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
                    Image(systemName: "building.2.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.purple)
                        .padding()
                    
                    Text("New York Building Violations")
                        .font(Font.custom("Savoye LET", size: 35))
                        .foregroundColor(.black.opacity(0.80))
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
