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
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                MapView()
                    .edgesIgnoringSafeArea(.top) 

                VStack {
                    HStack {
                        if viewStore.useFromToBox {
                            placeBarView(viewStore: self.store)
                        } else {
                            fromtoBarView()
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
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    private func placeBarView(viewStore: StoreOf<SearchLocationStore>) -> some View {
        Button(action: {
            viewStore.send(.searchLocationButtonTapped)
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
    }
    
    private func fromtoBarView() -> some View {
        HStack {
            VStack {
                fromSearchBar()
                toSearchBar()
            }
            
            Button(action: {
                // swapDepartureArrival()
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
    
    // MARK: from, to 해결 후
//    private func swapDepartureArrival() {
//        withAnimation {
//            let tmp = departure
//            departure = arrival
//            arrival = tmp
//        }
//    }
    
    private func fromSearchBar() -> some View {
        SearchBar(store: self.store, placeholder: "출발지")
    }
    
    private func toSearchBar() -> some View {
        SearchBar(store: self.store, placeholder: "도착지")
    }
}
