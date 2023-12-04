//
//  ZeroResultsFoundView.swift
//  MobDev Violations Project
//
//  Created by octopus on 12/4/23.
//

import SwiftUI

struct ZeroResultsFoundView: View {
    var message: String = "Please search for something else"
    var body: some View {
        VStack{
            Image(systemName: "rectangle.and.text.magnifyingglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)

            Text("0 results")
                .font(.headline)
                .padding()
            Text(message)
                .font(.subheadline)
        }
        .foregroundColor(.gray)
        Spacer()
    }
}

#Preview {
    ZeroResultsFoundView(message: "Please search for a different building")
}
