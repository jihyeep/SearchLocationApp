//
//  ContentView.swift
//  SearchLocation
//
//  Created by 박지혜 on 7/4/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var viewModel = MapViewModel()
    @State var style = 0
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Map(position: $viewModel.cameraPosition, selection: $viewModel.selectedPlace) {
                    ForEach(viewModel.searchResults, id: \.self) { place in
                        Annotation(place.name ?? "", coordinate: place.placemark.coordinate) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundStyle(.pink)
                                .background(.white)
                                .clipShape(Circle())
                        }
                    }
                    // 경로 만들기
                    if let route = viewModel.route {
                        MapPolyline(route.polyline)
                            .stroke(.blue, lineWidth: 5)
                    }
                }
                // 현재 위치 버튼
                .mapControls {
                    MapScaleView()
                    MapUserLocationButton()
                }
                .mapStyle(viewModel.mapStyle)
                .navigationTitle("SearchLocation")
                .searchable(text: $viewModel.searchText)
                // 세그먼트 선택
                 Picker("Map Style", selection: $style) {
                     Text("Standard").tag(0)
                     Text("Imagery").tag(1)
                     Text("Hybrid").tag(2)
                 }
                 .pickerStyle(SegmentedPickerStyle())
                 .padding()
                 .onChange(of: style) { newValue in
                     switch newValue {
                     case 0:
                         viewModel.mapStyle = .standard
                     case 1:
                         viewModel.mapStyle = .imagery
                     case 2:
                         viewModel.mapStyle = .hybrid
                     default:
                         viewModel.mapStyle = .standard
                     }
                 }
                if viewModel.selectedPlace != nil {
                    PlaceInfoPanel(viewModel: viewModel)
                        .padding()
                }
            }
        }
        .onSubmit(of: .search) {
            viewModel.searchLocation()
        }
    }
}

#Preview {
    ContentView()
}
