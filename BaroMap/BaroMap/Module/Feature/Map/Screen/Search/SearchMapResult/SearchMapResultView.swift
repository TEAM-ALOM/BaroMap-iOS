//
//  MapSearchResultView.swift
//  BaroMap
//
//  Created by 이소리 on 1/7/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchMapResultView: View {
    let store: StoreOf<SearchMapResultStore>
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                MapView()
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    Spacer()
                    
                    PlaceBox(store: self.store)
                        .padding()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .onAppear {
                viewStore.send(.detailViewTapped(true))
            }
            .onDisappear {
                viewStore.send(.detailViewTapped(false))
            }
        }
    }
}

struct PlaceBox: View {
    let store: StoreOf<SearchMapResultStore>
    
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
                            Text("\(viewStore.place.placeName)")
                                .font(.subheadline)
                                .bold()
                            
                            // Spacer() 너무 내려감, linespacing도 X
                            
                            Text("\(viewStore.place.placeAddress)")
                                .font(.footnote)
                        }
                        
                        Spacer()
                        
                        if Destination.shared.isLocationSearch {
                            setTypeButton(viewStore: self.store)
                        }
                        else {
                            goButton(viewStore: self.store)
                        }
                    }
                        .padding()
                )
        }
    }
    
    private func goButton(viewStore: StoreOf<SearchMapResultStore>) -> some View {
        Button {
            viewStore.send(.goButtonTapped)
        } label: {
            VStack {
                Image(systemName: "location.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.keyColor)
                
                Text("\(Destination.shared.type.placeholder)로")
                    .font(.footnote)
                    .foregroundColor(.keyColor)
            }
        }
    }
    
    private func setTypeButton(viewStore: StoreOf<SearchMapResultStore>) -> some View {
        Menu {
            Button("도착지로") {
                viewStore.send(.setToButtonTapped)
            }
            Button("출발지로") {
                viewStore.send(.setFromButtonTapped)
            }
        } label: {
            VStack {
                Image(systemName: "location.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.keyColor)
                
                Text("길찾기")
                    .font(.footnote)
                    .foregroundColor(.keyColor)
            }
        }
    }
}
