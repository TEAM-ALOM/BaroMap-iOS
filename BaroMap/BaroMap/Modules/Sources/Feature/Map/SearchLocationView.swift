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
    
    @State var departure: String = ""
    @State var arrival: String = ""
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                MapView()
                    .edgesIgnoringSafeArea(.top) // 탭바 지키기

                VStack {
                    HStack {
                        if viewStore.isDefectedArrowButtonVisible {
                            Button(action: {
                                viewStore.send(.searchLocationButtonTapped)
                            }, label: {
                                Text("장소 검색")
                                    .foregroundColor(.textQuaternaryColor)
                                    .underline(false)
                                    .frame(alignment: .leading)

                                Spacer() // 안 먹힘
                                
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
                                SearchDestinationView(store: destinationStore, placeholder: "장소")
                            }
                        }
                        else {
                            depArrBarView()
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
    
    private func depArrBarView() -> some View {
        HStack {
            VStack {
                SearchBar(store: self.store, placeholder: "출발지")
                SearchBar(store: self.store, placeholder: "도착지")
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

struct CircleButton: View {
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .resizable()
                .font(Font.title.weight(.bold))
                .frame(width: 40, height: 40)
                .foregroundColor(.keyColor)
                .clipShape(Circle())
                .background(Color.shapeColor)
                .cornerRadius(100)
        }
        .buttonStyle(.borderless)
    }
}

// 코드 중복 -> 재사용
struct SearchBar: View {
    let store: StoreOf<SearchLocationStore>

    var placeholder: String
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button(action: {
                viewStore.send(.searchLocationButtonTapped) 
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


//#Preview {
//    SearchLocationView()
//}
