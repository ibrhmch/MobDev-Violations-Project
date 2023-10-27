//
//  ContentView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BuildingsTabView()
                .tabItem{
                    Label("Buildings", systemImage: "building.2.fill")
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
    }
}

#Preview {
    ContentView()
}
