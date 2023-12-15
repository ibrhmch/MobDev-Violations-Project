//
//  VOsNOVsListCardView.swift
//  MobDev Violations Project
//
//  Created by octopus on 12/4/23.
//

import SwiftUI

struct VOsNOVsListCardView: View {
    var id = "some"
    var status = false
    
    var body: some View {
        HStack{
            Text(id)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
            
            Spacer()
            
            Circle()
                .foregroundColor(status ? Color("ActiveColor") : .purple)
                .frame(width: 10)
                .padding(.vertical)
        }
    }
}

#Preview {
    VOsNOVsListCardView()
}
