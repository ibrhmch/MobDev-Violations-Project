//
//  NoNetworkView.swift
//  MobDev Violations Project
//
//  Created by octopus on 12/14/23.
//

import SwiftUI

struct NoNetworkView: View {
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
                Text("Connected to Internet")
                    .foregroundColor(.green)
                    .padding()
            }
        }
    }
}

#Preview {
    NoNetworkView()
}
