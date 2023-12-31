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

        WindowGroup(id: "report") {
            ReportView()
         }
        .windowResizability(.contentSize)
 
        WindowGroup(id: "zoom-in"){
            ZoomInView()
                .frame(width: 1464, height: 1468)
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "trainMap") {
            TrainMapView()
        }
        .windowResizability(.contentSize)
        .windowStyle(.plain)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
		
		WindowGroup(id: "face-time") {
			FacetimeCallView()
		}
//		.windowStyle(.volumetric)
//        .defaultSize(width: 0.4, height: 0.4, depth: 0.1, in: .meters)
        .defaultSize(CGSize(width: 550, height: 540))
    }
}
