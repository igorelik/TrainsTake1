//
//  TrainMapView.swift
//  TrainsTake1
//
//  Created by Peter Watling on 23/8/2023.
//

import Foundation
import SwiftUI
import MapKit

struct TrainMapView: View {
   
   @State var location = LocationMonitor()

   
   @State private var camera = MapCameraPosition.region(.init(center: .init(latitude: -33.8832, longitude: 151.2070), span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03)))
      
   @State var selection: Station?
   @State var searchString: String = ""
   
   @State var stations = [Station]()
   
   var body: some View {
      NavigationSplitView {
         List(stations, id:\.self, selection: $selection) { station in
            Text(station.name).tag(station)
         }
         .searchable(text: $searchString, prompt: "NSW Train Station")
         .onChange(of: selection) { oldValue, newValue in
            withAnimation {
               if let newLocation = newValue?.location.coordinate {
                  self.camera = .camera(.init(centerCoordinate: newValue!.location.coordinate, distance: 600))
               }
            }
         }
         .onChange(of: searchString) { oldValue, newValue in
            if newValue == "" {
               stations = location.stations
               return
            }
            stations = location.stations.compactMap { station in
               if station.name.contains(newValue) {
                  return station
               } else { return nil }
            }
         }
         .onChange(of: location.stations) { oldValue, newValue in
            self.stations = newValue // Hack I know
         }
         .task {
             stations = location.stations
         }
         .navigationTitle("NSW Trains")
         .navigationSplitViewColumnWidth(250)

      } detail: {
         Map(position: $camera) {
            
         }
        
            .mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: [.publicTransport], showsTraffic: true))
      }

      
   }
        
   
}

#Preview {
   TrainMapView()
}

