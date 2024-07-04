//
//  MapViewModel.swift
//  SearchLocation
//
//  Created by 박지혜 on 7/4/24.
//

import SwiftUI
import MapKit

@Observable
class MapViewModel: NSObject, CLLocationManagerDelegate {
    // 위치 권한 허용하면 현재 위치 계속 업데이트
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var searchText = ""
    var mapStyle: MapStyle = .standard
    
    private var locationManager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init() /// NSObject
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func moveToCurrentLocation() {
        cameraPosition = .userLocation(fallback: .automatic)
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error: \(error.localizedDescription)")
    }
}
