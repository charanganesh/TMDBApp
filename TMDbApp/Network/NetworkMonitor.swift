//
//  NetworkMonitor.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import Foundation
import Network
import Observation

@Observable
class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}
