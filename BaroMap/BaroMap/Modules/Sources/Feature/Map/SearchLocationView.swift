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
    let store: StoreOf<SearchLocationStore> // store 연결
    
    @State var departure: String = ""
    @State var arrival: String = ""
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in // observe 이유는?
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
                                    .foregroundColor(.textTertiary)
                                    .underline(true)
                                    .frame(height: 12)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Spacer() // 안 먹힘
                                
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.textTertiary)
                            })
                            .background(Color.shapeColor) // shapeColor
                            .cornerRadius(10)
                            .fullScreenCover(
                                store: self.store.scope(
                                    state: \.$isShownSearchDestinationView,
                                    action: { .searching($0) }
                                )
                            ) { destinationStore in
                                SearchDestinationView(store: destinationStore, placeholder: "장소")
                            }
                        }
                        // 출발지-도착지 검색 바
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
                    .resizable()
                    .fontWeight(.bold)
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.keyColor)
            }
            .buttonStyle(.plain)
            .padding(5) // 패딩 이런식으로 주면 안 될 거 같은데
        }
        .padding(10)
        .background(Color.shapeColor)
        .cornerRadius(20)
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
        }
        .buttonStyle(.plain)
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
                    .frame(alignment: .leading)
                    .frame(height: 16)
                
                Spacer()
            })
            .buttonStyle(.plain)
            .padding(7)
            .background(Color.shapeSecondaryColor)
            .cornerRadius(9)
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
