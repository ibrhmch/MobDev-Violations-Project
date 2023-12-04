//
//  SearchForThisView.swift
//  MobDev Violations Project
//
//  Created by octopus on 12/4/23.
//

import SwiftUI

struct SearchForThisView: View {
    var message: String = "Please search for something"
    
    var body: some View {
        VStack{
            Image(systemName: "text.magnifyingglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Text(message)
                .padding()
                .font(.subheadline)
        }
        .foregroundColor(.gray)
        Spacer()
    }
}

#Preview {
    SearchForThisView(message: "Please search for something")
}
