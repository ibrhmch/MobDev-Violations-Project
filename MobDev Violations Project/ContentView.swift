//
//  ContentView.swift
//  MobDev Violations Project
//
//  Created by octopus on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false

    @StateObject var connectivity = NetworkConnectivity()

    var body: some View {
        VStack {
            if !connectivity.isConnected {
                ContentUnavailableView(
                            "No Internet Connection",
                            systemImage: "wifi.exclamationmark",
                            description: Text("Please check your connection and try again.")
                        )
            } else {
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
                            Label("VOs", systemImage: "signpost.and.arrowtriangle.up")
                    }
                    
                    NOVsTabView()
                        .tabItem{
                            Label("NOVs", systemImage: "signpost.right.and.left")
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
    }
}

#Preview {
    ContentView()
}
