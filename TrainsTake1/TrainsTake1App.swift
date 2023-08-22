//
//  TrainsTake1App.swift
//  TrainsTake1
//
//  Created by Igor Gorelik on 22/8/2023.
//

import SwiftUI

@main
struct TrainsTake1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
