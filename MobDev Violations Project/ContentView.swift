//
//  ContentView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false

    var body: some View {
        TabView {
            withAnimation(
                .easeIn(duration: 1.2)) {
                    BuildingsTabView()
                        .tabItem{
                            Label("Buildings", systemImage: "building.2.fill")
                    }
                }
            
            VOsTabView()
                .tabItem{
                    Label("VOs", systemImage: "signpost.left")
            }
            
            NOVsTabView()
                .tabItem{
                    Label("NOVs", systemImage: "signpost.right")
            }
            
            SettingsTabView()
                .tabItem{
                    Label("Settings",
                    systemImage: "gearshape")
            }
        }
        .preferredColorScheme(darkModeEnabled ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
