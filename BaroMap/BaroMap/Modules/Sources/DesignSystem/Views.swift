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
import UIKit

// 목적지 좌표 전달받아서 해당 위치로 1. 뷰 이동 2. pin 표시

struct MapView: UIViewRepresentable {

    let coord = NMGLatLng(lat: 37.55062, lng: 127.07440)
    let locationManager = CLLocationManager()
    let view = NMFNaverMapView()
    let pathOverlay = NMFPath()
    var isLocationTracking: Bool = true // 검색버튼 누를 때도 활성화됨

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

struct SearchBar: View {
    let store: StoreOf<SearchLocationStore>

//    @EnvironmentObject var sharedModel: SharedModel
    var placeholder: String
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button(action: {
                viewStore.send(.searchLocationButtonTapped)
                Destination.shared.placeholder = placeholder
                Destination.shared.isLocationSearch = false
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
                    action: { .searching($0) }
                )
            ) { destinationStore in
                SearchDestinationView(store: destinationStore)
            }
        }
    }
}

struct FilledSearchBar: View {
    let store: StoreOf<SearchLocationStore>

//    @EnvironmentObject var sharedModel: SharedModel
    var placeholder: String
        
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
                    action: { .searching($0) }
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

struct PlaceBox: View {
    let store: StoreOf<SearchDestinationStore>
    
//    @EnvironmentObject var sharedModel: SharedModel
    var locationName: String
    var locationAddress: String
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 95)
                .frame(maxWidth: .infinity)
                .foregroundColor(.shapeColor)
                .largeShadow()
                .padding(1)
                .overlay( // overlay 이유
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("\(locationName)")
                                .font(.subheadline)
                                .bold()
                            
                            // Spacer() 너무 내려감, linespacing도 X
                            
                            Text("\(locationAddress)")
                                .font(.footnote)
                        }
                        
                        Spacer()
                        
                        if Destination.shared.isLocationSearch {
                            SearchResultLocationButton(store: self.store, locationName: locationName, locationAddress: locationAddress)
                        }
                        else {
                            SearchReultDestinationButton(store: self.store)
                        }
                    }
                        .padding()
                )
        }
    }
}



struct SearchResultLocationButton: View {
    let store: StoreOf<SearchDestinationStore>
    
    var locationName: String
    var locationAddress: String // 중복됨
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Menu {
                Button("도착지로") {
                    viewStore.send(.cancelButtonTapped) //-> 보라색 오류(TCA)
                    Destination.shared.departure = locationName
                    print("\(locationName) 을/를 도착지로 설정함")
                    print("\(Destination.shared.departure) == \(locationName)")
                }
                Button("출발지로") {
                    viewStore.send(.cancelButtonTapped) // -> 보라색 오류(TCA)
                    // [출발지]에 값 저장 -> 출발지를 어디에 선언해야 하나
                    // call SearchLocationView(From: locationName) -> button에 x btn 추가
                    // 하나의 뷰 다른 버튼 -> toggle
                    Destination.shared.arrival = locationName
                    print("\(locationName) 을/를 출발지로 설정함")
                    print("\(Destination.shared.arrival) == \(locationName)")
                }
            } label: {
                VStack {
                    Image(systemName: "location.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.keyColor)
                    
                    Text("길찾기") // from 장소검색: menu(길찾기), 출발지: text(출발지로), 도착지: text(도착지로)
                        .font(.footnote)
                        .foregroundColor(.keyColor)
                }
            }

        }
    }
}
// 출발지로/도착지로 btn
struct SearchReultDestinationButton: View {
    let store: StoreOf<SearchDestinationStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button {
                viewStore.send(.cancelButtonTapped) // -> 보라색 오류(TCA)
            } label: {
                VStack {
                    Image(systemName: "location.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.keyColor)
                    
                    Text("\(Destination.shared.placeholder)로")
                        .font(.footnote)
                        .foregroundColor(.keyColor)
                }
            }
        }
    }
}

class SharedModel: ObservableObject {
    @Published var placeholder: String = "장소"
    @Published var locationName: String = "locationName from sharedModel"
    @Published var locationAddress: String = "locationAddress from sharedModel"
}

class Destination {
    static let shared = Destination()

    private init() { }

    var placeholder: String = "placeholder" // 장소.도착지.출발지
    var departure: String = "departure" // 출발지 이름
    var arrival: String = "arrival"      // 도착지 이름
    var isLocationSearch: Bool = true
}

//#Preview {
//    Views()
//}
