//
//  MapViewModel.swift
//  SearchLocation
//
//  Created by 박지혜 on 7/4/24.
//

import SwiftUI
import MapKit

@Observable
class MapViewModel {
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var searchText = ""
    var mapStyle: MapStyle = .standard
}
