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
        
        var from: String = "강남구청역"
        var to: String = ""
    }
    
    enum Action: Equatable {
        case toggleButtonTapped
        case myLocationButtonTapped
        case changeType(PlaceSearchType)
        case searching(PresentationAction<SearchDestinationStore.Action>)
        
        case updateFrom(String)
        case updateTo(String)
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
                state.isShownSearchDestinationView = SearchDestinationStore.State(title: placeSearchType)
                return .none
                                
            case .searching:
                return .none
                
            case .updateFrom(let text):
                state.from = text
                return .none

            case .updateTo(let text):
                state.to = text
                return .none
            }
        }
        .ifLet(\.$isShownSearchDestinationView, action: /Action.searching) {
            SearchDestinationStore()
        }
    }
}
