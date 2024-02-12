//
//  SearchLocationStore.swift
//  BaroMap
//
//  Created by 이소리 on 11/10/23.
//

import Foundation
import ComposableArchitecture
import Combine

struct SearchLocationStore: Reducer {
    
    struct State: Equatable {
        
        @PresentationState var isShownSearchDestinationView: SearchDestinationStore.State?

        var isEnabled: Bool = false
        var isLocationTracking: Bool = true
        var selectedButton: String?
    }
    
    enum Action: Equatable {
        case toggleButtonTapped
        case myLocationButtonTapped
        case changeType(SearchLocationView.PlaceSearchType)
        case next(PresentationAction<SearchDestinationStore.Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .toggleButtonTapped:
                state.isEnabled.toggle()
                return .none

            case .myLocationButtonTapped:
                state.isLocationTracking.toggle()
                return .none

            case .changeType(let placeSearchType):
                state.isShownSearchDestinationView = SearchDestinationStore.State(title: placeSearchType.placeholder)
                return .none
                                
            case .next:
                return .none
            }
        }
        .ifLet(\.$isShownSearchDestinationView, action: /Action.next) {
            SearchDestinationStore()
        }
    }
}
