//
//  SearchLocationView.swift
//  classPractice
//
//  Created by 이소리 on 11/10/23.
//

import SwiftUI
import ComposableArchitecture
import NMapsMap
import CoreLocation

// FIXME: MapView 분리 필요
struct MapView: UIViewRepresentable {
    let coord = NMGLatLng(lat: 37.55062, lng: 127.07440)
    let locationManager = CLLocationManager()

    class Coordinator: NSObject, NMFMapViewCameraDelegate, CLLocationManagerDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }

    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        
        view.showZoomControls = false
        view.showLocationButton = true
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

        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}

struct SearchLocationView: View {
    let store: StoreOf<SearchLocationStore> // store 연결
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in // observe 이유는?
            ZStack {
                MapView()
                    .edgesIgnoringSafeArea(.top) // 탭바 지키기

                VStack {
                    HStack {
                        Button(action: {
                            viewStore.send(.searchLocationButtonTapped)
                        }, label: {
                            Text("장소 검색")
                                .foregroundColor(.textTertiary)
                                .underline(true)
                                .frame(height: 10)
                                .frame(maxWidth: .infinity)
                            
                            Spacer() // 안 먹힘
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.textTertiary)
                        })
                        .background(Color.shapeColor) // 버튼 때문에 색이 뿌얘짐
                        .cornerRadius(10)
                        .fullScreenCover(
                            store: self.store.scope(
                                state: \.$isShownSearchDestinationView,
                                action: { .searching($0) }
                            )
                        ) { destinationStore in
                            SearchDestinationView(store: destinationStore)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        if viewStore.isDefectedArrowButtonVisible {
                            CircleButton(image: "arrow.triangle.turn.up.right.circle.fill") {
                                viewStore.send(.getDirectionsButtonTapped)
                            }
                        }
                        else {
                            CircleButton(image: "xmark.circle.fill") {
                                viewStore.send(.getDirectionsButtonTapped)
                            }
                        }
                    }
                }
                .padding()
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
                .font(Font.title.weight(.bold))
                .frame(width: 30, height: 30)
                .foregroundColor(.keyColor)
                .clipShape(Circle())
        }
    }
}

//#Preview {
//    SearchLocationView()
//}
