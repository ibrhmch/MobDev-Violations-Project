//
//  NoNetworkViewModel.swift
//  MobDev Violations Project
//
//  Created by octopus on 12/14/23.
//

import Foundation
import Network

class NetworkConnectivity: ObservableObject {
    let monitor: NWPathMonitor
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = true

    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
