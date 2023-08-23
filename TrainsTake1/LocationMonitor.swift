//
//  LocationMonitor.swift
//  Guard
//
//  Created by Peter Watling on 16/8/2023.
//

import Foundation
import CoreLocation

struct Station: Hashable {
    let name: String
    let location: CLLocation
    
    func distance(from target: CLLocation) -> CLLocationDistance {
        return location.distance(from: target)
    }
}

class LocationMonitor: NSObject, ObservableObject {
    
    static let shared = LocationMonitor()
    // private var monitor: CLMonitor? // Monitor Geofences and beacons
    
    private let manager = CLLocationManager()
    private let session = CLBackgroundActivitySession()
    private var updates: CLLocationUpdate.Updates?
    @Published var isStationary = false
    @Published var location: CLLocation? // CLLocation.init(latitude: -33.88388163, longitude: 151.2058293)
    @Published var station: Station?

    var stations = [Station]()
    
    
    func loadStationData() {
        let url = Bundle.main.url(forResource: "LocationFacilityData", withExtension: "tsv")!
        let allData = try! String(contentsOf: url)
        let lines = allData.components(separatedBy: "\n")
        for line in lines {
            let items = line.components(separatedBy: "\t")
            if items[9].contains("Train") && items[6].contains("NSW"){
                 stations.append(Station(name: items[0], location: .init(latitude: Double(items[2])!, longitude: Double(items[3])!)))
            }
        }
        
        print("Now we have \(stations.count)")
    }
    
    func station(closestTo target: CLLocation) -> Station? {
        
        var closestDistance = Double.greatestFiniteMagnitude
        var foundStation: Station?
        
        for station in stations {
            let distance = station.distance(from: target)
            if distance < closestDistance {
                foundStation = station
                closestDistance = distance
            }
        }
        print("Closest Station distance was \(closestDistance)m")
        return foundStation
    }
    
    override init() {
        print("Init of location monitor")
        super.init()
        loadStationData()
       // setupLocation()
    }
    
    func startMonitoring() {
        
        updates = CLLocationUpdate.liveUpdates(.automotiveNavigation)
        
        print("Started monitoring for updates")
         Task {
            for try await update in updates! {
                print("Got an update")
                DispatchQueue.main.async {
                    self.isStationary = update.isStationary
                    self.location = update.location
                    if let location = update.location, let station = self.station(closestTo: location) {
                        print("Close to \(station.name)")
                        self.station = station
                    }
                }
            }
        }
    }
    
    func setupLocation() {
      //  manager.desiredAccuracy = kCLLocationAccuracyReduced
        manager.delegate = self
     //   manager.allowsBackgroundLocationUpdates = true
        manager.showsBackgroundLocationIndicator = true
 //       manager.pausesLocationUpdatesAutomatically = false
        
    //    manager.requestAlwaysAuthorization()
    }
}

extension LocationMonitor: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("Always")
            startMonitoring()
        case .denied:
            print("Denied")
        case .authorizedWhenInUse:
            print("When in use")
        case .restricted:
            print("Restricted")
        case .notDetermined:
            print("Not determined")
        @unknown default:
            print("Unknown")
        }
    }
}
