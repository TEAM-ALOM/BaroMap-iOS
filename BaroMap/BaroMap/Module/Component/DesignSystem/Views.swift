//
//  Views.swift
//  BaroMap
//
//  Created by 이소리 on 1/5/24.
//

import SwiftUI
import ComposableArchitecture
import NMapsMap
import CoreLocation

struct MapView: UIViewRepresentable {

    let coord = NMGLatLng(lat: 37.55062, lng: 127.07440)
    let locationManager = CLLocationManager()
    let view = NMFNaverMapView()
    let pathOverlay = NMFPath()
    // FIXME: 검색버튼 누를 때도 활성화됨
    var isLocationTracking: Bool = true

    class Coordinator: NSObject, NMFMapViewCameraDelegate, CLLocationManagerDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }

    func makeUIView(context: Context) -> NMFNaverMapView {

        view.showZoomControls = false
        view.showLocationButton = false
        view.showCompass = false
        view.showIndoorLevelPicker = true
        view.mapView.positionMode = .direction
        
        // 위치 설정
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        view.mapView.moveCamera(cameraUpdate)
        print("위도: \(coord.lat), 경도: \(coord.lng)")

        // 사용자 위치 정보 요청 설정
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = context.coordinator
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        // MARK: 경로선 오버레이
//        pathOverlay.path = NMGLineString(points: [
//            NMGLatLng(lat: 37.57152, lng: 126.97714),
//            NMGLatLng(lat: 37.56607, lng: 126.98268),
//            NMGLatLng(lat: 37.56445, lng: 126.97707),
//            NMGLatLng(lat: 37.55855, lng: 126.97822)
//        ])
//        
//        pathOverlay.mapView = view.mapView
            
        return view
    }
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        uiView.mapView.positionMode = isLocationTracking ? .direction : .disabled // .normal
    }
}

struct FilledSearchBar: View {
    let store: StoreOf<SearchLocationStore>

    let placeholder: String
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button(action: {
                
            }, label: {
                Text(placeholder)
                    .foregroundColor(.textQuaternaryColor)
                    .underline(false)
                    .frame(alignment: .leading)
                
                Spacer()
            })
            .buttonStyle(.borderless)
            .frameStyle(backgroundColor: Color.shapeSecondaryColor, cornerRadius: 10, padding: 8)
            
            .fullScreenCover(
                store: self.store.scope(
                    state: \.$isShownSearchDestinationView,
                    action: { .next($0) }
                )
            ) { destinationStore in
                SearchDestinationView(store: destinationStore)
            }
        }
    }
}

struct CircleButton: View {
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .resizable()
                .font(Font.title.weight(.bold))
                .foregroundColor(.keyColor)
                .frame(width: 40, height: 40)
                .background(Circle().fill(Color.shapeColor))
        }
        .buttonStyle(.borderless)
    }
}

struct myLocationButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "scope")
                .font(Font.title.weight(.bold))
                .foregroundColor(.keyColor)
                .frame(width: 40, height: 40)
                .background(Circle().fill(Color.shapeColor))
        }
        .buttonStyle(.borderless)
    }
}


// 출발지로/도착지로 btn

class Destination {
    static let shared = Destination()

    private init() { }

    var text: String = ""
    var searching: Place = Place(placeName: "", placeAddress: "", coord: Coordinate(latitude: 0.0, longitude: 0.0), distance: 0.0)
    var from: Place = Place(placeName: "", placeAddress: "", coord: Coordinate(latitude: 0.0, longitude: 0.0), distance: 0.0)
    var to: Place = Place(placeName: "", placeAddress: "", coord: Coordinate(latitude: 0.0, longitude: 0.0), distance: 0.0)
    var type: SearchLocationView.PlaceSearchType = .searching
    var isLocationSearch: Bool = true
    
    func navigateToMapView()  {
        guard !from.placeName.isEmpty, !to.placeName.isEmpty else {
            return
        }
    }
}
