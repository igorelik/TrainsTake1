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
        .windowResizability(.contentSize)
        .windowStyle(.plain)

        WindowGroup(id: "cctv") {
            CCTVView()
         }
        .windowResizability(.contentSize)
        //.defaultSize(width: 1.5, height: 2.5, depth: 0.6, in: .meters)

        WindowGroup(id: "report") {
            ReportView()
         }
        .windowResizability(.contentSize)
 
        WindowGroup(id: "trainMap") {
            TrainMapView()
        }
        .windowResizability(.contentSize)

		WindowGroup(id: "face-time") {
			FacetimeCallView()
		}
        .windowResizability(.contentSize)
        .windowStyle(.volumetric)
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)
    }
}
