//
//  SearchFieldModifiers.swift
//  MobDev Violations Project
//
//  Created by octopus on 12/4/23.
//

import SwiftUI

extension Color {
    static let darkPink = Color(red: 208 / 255, green: 45 / 255, blue: 208 / 255)
}
extension View {
    func underlineTextField() -> some View {
        self
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.black)
            .padding(10)
    }
}
