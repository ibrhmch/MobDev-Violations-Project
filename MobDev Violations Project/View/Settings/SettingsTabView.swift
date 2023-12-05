//
//  SettingsTabView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct SettingsTabView: View {
    @State var isExpanded = false
    @State var notificationsOn = false
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @State var barVerticalPadding: CGFloat = 10

    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Toggle("Notification Alerts",
                            isOn: $notificationsOn)
                    .padding(.horizontal)
                    .padding(.vertical, barVerticalPadding)
                    .background(.fill)
                    .cornerRadius(5)
                }
                .padding(.horizontal)
                
                HStack{
                    Toggle("Dark Mode",
                            isOn: $darkModeEnabled.animation(.easeInOut(duration: 0.5)))
                    .padding(.horizontal)
                    .padding(.vertical, barVerticalPadding)
                    .background(.fill)
                    .cornerRadius(5)
                }
                .padding(.horizontal)
                
                Spacer()
                
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .font(.subheadline)
            .padding(.top, 30)
        }
    }
}

#Preview {
    SettingsTabView()
}
