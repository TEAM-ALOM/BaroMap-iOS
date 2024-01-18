//
//  SearchLocationView.swift
//  BaroMap
//
//  Created by 이소리 on 11/10/23.
//

import SwiftUI
import ComposableArchitecture
import NMapsMap
import CoreLocation

struct SearchLocationView: View {
    let store: StoreOf<SearchLocationStore>
    
//    @EnvironmentObject var sharedModel: SharedModel -> 왜안돼

    
    @State var departure: String = ""
    @State var arrival: String = ""
//    @Binding var isLocationTracking = false
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                MapView()
                    .edgesIgnoringSafeArea(.top) // 탭바 지키기

                VStack {
                    HStack {
                        if viewStore.useFromToBox {
                            Button(action: {
                                viewStore.send(.searchLocationButtonTapped)
                                Destination.shared.placeholder = "장소"
                            }, label: {
                                Text("장소 검색")
                                    .foregroundColor(.textQuaternaryColor)
                                    .underline(false)
                                    .frame(alignment: .leading)
                                
                                Spacer()
                                
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.textQuaternaryColor)
                                    .fontWeight(.semibold)
                            })
                            .buttonStyle(.borderless)
                            .frameStyle(backgroundColor: Color.shapeColor, cornerRadius: 10, padding: 8)
                            .largeShadow()
                            .fullScreenCover(
                                store: self.store.scope(
                                    state: \.$isShownSearchDestinationView,
                                    action: { .searching($0) }
                                )
                            ) { destinationStore in
                                SearchDestinationView(store: destinationStore)
                            }
                            
                        } else {
                            depArrBarView()
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            CircleButton(image: viewStore.useFromToBox ? "arrow.triangle.turn.up.right.circle.fill" : "xmark.circle.fill") {
                                viewStore.send(.getDirectionsButtonTapped)
                            }
                            
                            myLocationButton() {
                                viewStore.send(.myLocationButtonTapped)
                            }
//                            {
//                                viewStore.send(.myLocationButtonTapped)
//                            }
                        }
                    }
                    
                    // [op]
                    // PlaceBox(locationName: viewStore.locationName, locationAddress: viewStore.locationAddress) // useFromToBox && filled(출발지 or 도착지)
                }
                .padding()
            }
        }
    }
    
    private func depArrBarView() -> some View {
        HStack {
            VStack {
                DepartureSearchBar(store: self.store)
                DestinationSearchBar(store: self.store)
            }
            
            Button(action: {
                swapDepartureArrival()
            }) {
                Image(systemName: "arrow.up.arrow.down")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.keyColor)
            }
            .buttonStyle(.borderless)
        }
        .frameStyle(backgroundColor: Color.shapeColor, cornerRadius: 20, padding: 11)
        .largeShadow()
    }
    
    private func swapDepartureArrival() {
        withAnimation {
            let tmp = departure
            departure = arrival
            arrival = tmp
        }
    }
}

struct DepartureSearchBar: View {
    let store: StoreOf<SearchLocationStore>
    
//    @EnvironmentObject var sharedModel: SharedModel
    
    var body: some View {
        SearchBar(store: self.store, placeholder: "출발지") // 여기서 값 할당
    }
}

struct DestinationSearchBar: View {
    let store: StoreOf<SearchLocationStore>
    
//    @EnvironmentObject var sharedModel: SharedModel
    
    var body: some View {
        SearchBar(store: self.store, placeholder: "도착지")
    }
}

//#Preview {
//    SearchLocationView()
//}
