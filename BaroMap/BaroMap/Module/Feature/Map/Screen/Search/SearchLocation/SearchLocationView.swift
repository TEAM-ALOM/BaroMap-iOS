//
//  SearchLocationView.swift
//  BaroMap
//
//  Created by 이소리 on 11/10/23.
//

import SwiftUI
import ComposableArchitecture

struct SearchLocationView: View {
    let store: StoreOf<SearchLocationStore>
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                MapView()
                    .edgesIgnoringSafeArea(.top)
                
                VStack {
                    // TODO: 나중에 view로 따로 뺄게요
                    HStack {
                        if !viewStore.isEnabled {
                            placeSearchBar(viewStore: self.store)
                        } else {
                            fromtoSearchBar(viewStore: self.store)
                        }
                    }
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            CircleButton(image: !viewStore.isEnabled ? "arrow.triangle.turn.up.right.circle.fill" : "xmark.circle.fill") {
                                viewStore.send(.toggleButtonTapped)
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
    
    // TODO: struct로 변경하겠습니다
    private func placeSearchBar(viewStore: StoreOf<SearchLocationStore>) -> some View {
        Button(action: {
            viewStore.send(.changeType(.searching))
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
                action: { .next( $0 ) }
            )
        ) { destinationStore in
            SearchDestinationView(store: destinationStore)
        }
    }
    
    public func fromtoSearchBar(viewStore: StoreOf<SearchLocationStore>) -> some View {
        HStack {
            VStack {
                SearchBar(store: self.store, placeHolder: "출발지") {
                    viewStore.send(.changeType(.from))
                }
                SearchBar(store: viewStore, placeHolder: "도착지") {
                    viewStore.send(.changeType(.to))
                }
            }
            
            // MARK: swap action
            Button(action: {
                    
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
}

struct SearchBar: View {
    let store: StoreOf<SearchLocationStore>
    let placeHolder: String
    let action: () -> Void
                
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button(
                action: action,
                label: {
                Text(placeHolder)
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
                    action: { .next( $0 ) }
                )
            ) { destinationStore in
                SearchDestinationView(store: destinationStore)
            }
        }
    }
}
