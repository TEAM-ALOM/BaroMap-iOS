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
                            fromtoSearchBar(store: self.store)
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
                action: { .searching( $0 ) }
            )
        ) { destinationStore in
            SearchDestinationView(store: destinationStore)
        }
    }
}

struct fromtoSearchBar: View {
    let store: StoreOf<SearchLocationStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                VStack {
                    if viewStore.from.isEmpty {
                        SearchBar(store: self.store, placeHolder: "출발지") {
                            viewStore.send(.changeType(.from))
                        }
                    } else {
                        HStack {
                            TextField("", text: viewStore.binding(get: { $0.from }, send: SearchLocationStore.Action.updateFrom))
                            
                            Spacer()
                            
                            if !viewStore.from.isEmpty {
                                Button(action: {
                                    viewStore.send(.updateFrom(""))
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.shapeQuaternaryColor)
                                }
                                .buttonStyle(.borderless)
                            } else {
                                
                            }
                        }
                        .asTextField()
                    }
                    
                    if viewStore.to.isEmpty {
                        SearchBar(store: self.store, placeHolder: "도착지") {
                            viewStore.send(.changeType(.to))
                        }
                    } else {
                        HStack {
                            TextField("", text: viewStore.binding(get: { $0.to }, send: SearchLocationStore.Action.updateTo))
                            
                            Spacer()
                            
                            if !viewStore.from.isEmpty {
                                Button(action: {
                                    viewStore.send(.updateFrom(""))
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.shapeQuaternaryColor)
                                }
                                .buttonStyle(.borderless)
                            } else {
                                EmptyView()
                            }
                        }       
                        .asTextField()
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
                    .padding(.leading, 7)
                
                Spacer()
            })
            .buttonStyle(.borderless)
            .frameStyle(backgroundColor: Color.shapeSecondaryColor, cornerRadius: 10, padding: 8)
            .fullScreenCover(
                store: self.store.scope(
                    state: \.$isShownSearchDestinationView,
                    action: { .searching( $0 ) }
                )
            ) { destinationStore in
                SearchDestinationView(store: destinationStore)
            }
        }
    }
}
