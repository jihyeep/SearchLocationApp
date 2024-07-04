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
    var searchResults: [MKMapItem] = []
    var selectedPlace: MKMapItem?
    var route: MKRoute?
    
    private var locationManager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init() /// NSObject
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func moveToCurrentLocation() {
        cameraPosition = .userLocation(fallback: .automatic)
    }
    
    func searchLocation() {
        print("search!")
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        // region은 주지 않음 - 넓은 범위에서 검색
        request.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let response = response else { return }
            self?.searchResults = response.mapItems
        }
    }
    
    func getDirection() {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = selectedPlace!
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        // 비동기 호출
        directions.calculate { [weak self] response, error in
            guard let response = response else { return }
            self?.route = response.routes.first
            
        }
    }

    func shareLocation() {
        print("share location")
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error: \(error.localizedDescription)")
    }
}
