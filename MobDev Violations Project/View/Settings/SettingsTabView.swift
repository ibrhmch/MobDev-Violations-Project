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
                            isOn: $darkModeEnabled)
                    .padding(.horizontal)
                    .padding(.vertical, barVerticalPadding)
                    .background(.fill)
                    .cornerRadius(5)
                }
                .padding(.horizontal)
                
                HStack{
                    VStack {
                        HStack{
                            Text("Subscribed Buildings")
                            Spacer()
                            Image(systemName: !isExpanded ? "rectangle.expand.vertical" : "rectangle.compress.vertical")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(.gray)
                                .cornerRadius(5)
                        }
                        if isExpanded {
                            ScrollView{
                                Text("More Info")
                                Text("And more")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, barVerticalPadding)
                    .frame(maxWidth: .infinity)
                    .background(.fill)
                    .cornerRadius(5)
                    .transition(.move(edge: .trailing))
                    .onTapGesture {
                        withAnimation(
                            .easeOut(duration: 0.2)) {
                                isExpanded.toggle()
                            }
                    }
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
