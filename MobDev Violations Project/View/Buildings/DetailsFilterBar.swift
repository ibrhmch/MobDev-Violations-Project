//
//  DetailsFilterBar.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/30/23.
//

import SwiftUI

struct FilterBar: View {
    @State private var selectedOption: Int = 0
    private let buttonWidth: CGFloat = 100
    private let textHeight: CGFloat = 45
    private let buttonHeight: CGFloat = 40
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack {
                // Highlighted Rectangle
                Rectangle()
                    .frame(width: buttonWidth, height: buttonHeight)
                    .foregroundColor(Color(red: 127/255, green: 151/255, blue: 204/255))
                    .cornerRadius(20)
                    .offset(x: CGFloat(selectedOption) * buttonWidth - buttonWidth)
                    .transition(.slide)
                    .padding(.horizontal, 5)
                
                // Buttons
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation {
                            selectedOption = 0
                        }
                    }) {
                        Text("Active")
                            .frame(width: buttonWidth, height: textHeight)
                            .background(Color.clear)
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        withAnimation {
                            selectedOption = 1
                        }
                    }) {
                        Text("All")
                            .frame(width: buttonWidth, height: textHeight)
                            .background(Color.clear)
                            .foregroundColor(.black)
                            .padding(.horizontal, 5)
                    }
                    
                    Button(action: {
                        withAnimation {
                            selectedOption = 2
                        }
                    }) {
                        Text("Dismissed")
                            .frame(width: buttonWidth, height: textHeight)
                            .background(Color.clear)
                            .foregroundColor(.black)
                    }
                }
            }
            .background(Color(red: 216/255, green: 225/255, blue: 235/255))
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black.opacity(0.2), lineWidth: 1)
            )
            .frame(width: buttonWidth * 3)
            .padding()
    
            Spacer()
        }
        .padding()
    }
}


#Preview {
    FilterBar()
}
