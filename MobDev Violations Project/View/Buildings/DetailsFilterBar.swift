//
//  DetailsFilterBar.swift
//  MobDev Violations Project
//
//  Created by octopus on 11/30/23.
//

import SwiftUI

struct FilterBar: View {
    @Binding var selectedFilterOption: Int
    private let buttonWidth: CGFloat = 100
    private let textHeight: CGFloat = 45
    private let buttonHeight: CGFloat = 40
    var defaultColor: Color = Color(red: 127/255, green: 151/255, blue: 204/255)
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack {
                // Highlighted Rectangle
                Rectangle()
                    .frame(width: buttonWidth, height: buttonHeight)
                    .foregroundColor(selectedFilterOption == 1 ? defaultColor : (selectedFilterOption == 0) ? .green : .purple)
                    .cornerRadius(15)
                    .offset(x: CGFloat(selectedFilterOption) * buttonWidth - buttonWidth)
                    .transition(.slide)
                    .padding(.horizontal, 5)
                
                // Buttons
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation {
                            selectedFilterOption = 0
                        }
                    }) {
                        Text("Active")
                            .frame(width: buttonWidth, height: textHeight)
                            .background(Color.clear)
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        withAnimation {
                            selectedFilterOption = 1
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
                            selectedFilterOption = 2
                        }
                    }) {
                        Text("Dismissed")
                            .frame(width: buttonWidth, height: textHeight)
                            .background(Color.clear)
                            .foregroundColor(.black)
                    }
                }
            }
            .background(.bar)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black.opacity(0.2), lineWidth: 0)
            )
            .frame(width: buttonWidth * 3)
            .font(.subheadline)
    
            Spacer()
        }
    }
}
