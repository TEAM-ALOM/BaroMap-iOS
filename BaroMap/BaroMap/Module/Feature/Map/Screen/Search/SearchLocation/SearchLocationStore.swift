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
    }
    
    enum Action: Equatable {
        case toggleButtonTapped
        case myLocationButtonTapped
        case changeType(PlaceSearchType)
        case searching
        case from
        case to
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
                state.isShownSearchDestinationView = SearchDestinationStore.State()
                return .run { send in
                    switch placeSearchType {
                    case .searching:
                        await send(.searching)
                        
                    case .from:
                        await send(.from)
                        
                    case .to:
                        await send(.to)
                    }
                }

            default:
                return .none
            }
        }
        .ifLet(\.$isShownSearchDestinationView, action: /Action.next) {
            SearchDestinationStore()
        }
    }
}
