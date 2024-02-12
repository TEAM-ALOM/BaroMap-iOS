//
//  MapSearchResultStore.swift
//  BaroMap
//
//  Created by 이소리 on 1/5/24.
//

import Foundation
import ComposableArchitecture

struct SearchMapResultStore: Reducer {
    struct State: Equatable {
        var type: PlaceSearchType
        var placeName: String
        var placeAddress: String
        var isMenu: Bool = true
    }
    
    enum Action: Equatable {
        case onAppear
        case goButtonTapped
        case setFromButtonTapped
        case setToButtonTapped
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if state.type == .searching {
                    state.isMenu = true
                }
                else {
                    state.isMenu = false
                }
                return .none
                
            case .goButtonTapped:
                return .run { _ in await self.dismiss() }

            case .setFromButtonTapped:
                return .run { _ in await self.dismiss() }

            case .setToButtonTapped:
                return .run { _ in await self.dismiss() }

            }
        }
    }
}
