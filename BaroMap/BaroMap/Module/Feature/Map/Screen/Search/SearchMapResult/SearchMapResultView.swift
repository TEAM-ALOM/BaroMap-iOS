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
                .overlay( 
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("\(viewStore.placeName)")
                                .font(.subheadline)
                                .bold()
                            
                            // Spacer() 너무 내려감, linespacing도 X
                            
                            Text("\(viewStore.placeAddress)")
                                .font(.footnote)
                        }
                        
                        Spacer()
                        
                        if viewStore.isMenu {
                            setTypeButton(viewStore: self.store)
                        }
                        else {
                            goButton(viewStore: self.store)
                        }
                    }
                        .padding()
                )
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
    }
    
    private func goButton(viewStore: Store<SearchMapResultStore.State, SearchMapResultStore.Action>) -> some View {
        Button {
            viewStore.send(.goButtonTapped)
        } label: {
            VStack {
                Image(systemName: "location.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.keyColor)
                
                // FIXME: state 접근이 안 됨
//                Text("\(viewStore.state.type.placeholder)로")
//                    .font(.footnote)
//                    .foregroundColor(.keyColor)
            }
        }
    }
    
    private func setTypeButton(viewStore: Store<SearchMapResultStore.State, SearchMapResultStore.Action>) -> some View {
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
