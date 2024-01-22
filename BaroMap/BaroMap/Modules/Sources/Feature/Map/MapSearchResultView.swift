//
//  MapSearchResultView.swift
//  BaroMap
//
//  Created by 이소리 on 1/7/24.
//

import SwiftUI
import ComposableArchitecture

struct MapSearchResultView: View {
    let store: StoreOf<SearchDestinationStore>
    
    var locationName: String
    var locationAddress: String
//    @Binding var isLocationTracking: Bool
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                MapView()
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    Spacer()
                    
                    PlaceBox(store: self.store, locationName: locationName, locationAddress: locationAddress)
                        .padding()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .onAppear {
                viewStore.send(.toggleDetailView(true))
            }
            .onDisappear {
                viewStore.send(.toggleDetailView(false))
            }
        }
    }
}

//#Preview {
//    MapSearchResultView()
//}
