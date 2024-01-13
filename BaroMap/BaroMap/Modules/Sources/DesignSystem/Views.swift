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
    @State private var myLocationButton: NMFLocationButton?

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
        
        view.showZoomControls = false // 뷰 따로
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

        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
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

struct SearchBar: View {
    let store: StoreOf<SearchLocationStore>

//    @EnvironmentObject var sharedModel: SharedModel
    var placeholder: String
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button(action: {
                viewStore.send(.searchLocationButtonTapped)
                
//                sharedModel.placeholder = placeholder
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
                SearchDestinationView(store: destinationStore, placeholder: placeholder)
            }
        }
    }
}

struct myLocationButton: View {
    var body: some View {
        Button {
            print("현재 위치로 이동")
        } label: {
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
    
//    @EnvironmentObject var sharedModel: SharedModel
    var locationName: String
    var locationAddress: String

    var body: some View {
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
                    // [op]-----
                    // 장소 검색에서 넘어오면 menu, fromtobox에서 넘어오면 button -> placeholder에 따라
                    Menu {
                        Button("도착지로") {
                            // viewStore.send(.cancelButtonTapped) -> 보라색 오류(TCA)
                            print("\(locationName) 을/를 도착지로 설정함")
                        }
                        Button("출발지로") {
                            // viewStore.send(.cancelButtonTapped) -> 보라색 오류(TCA)
                            // [출발지]에 값 저장 -> 출발지를 어디에 선언해야 하나
                            // call SearchLocationView(From: locationName) -> button에 x btn 추가
                            // 하나의 뷰 다른 버튼 -> toggle
                            print("\(locationName) 을/를 출발지로 설정함")
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
                    // -----
                }
                    .padding()
            )
    }
}

class SharedModel: ObservableObject {
    @Published var placeholder: String = "장소"
    @Published var locationName: String = "locationName from sharedModel"
    @Published var locationAddress: String = "locationAddress from sharedModel"
}


//#Preview {
//    Views()
//}
