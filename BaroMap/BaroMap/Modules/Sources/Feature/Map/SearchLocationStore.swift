//
//  SearchLocationStore.swift
//  BaroMap
//
//  Created by 이소리 on 11/10/23.
// abc

import Foundation
import ComposableArchitecture

struct SearchLocationStore: Reducer {
    struct State: Equatable {
        @PresentationState var isShownSearchDestinationView: SearchDestinationStore.State?
        
        var isDefectedArrowButtonVisible: Bool = true
        var placeholder: String
    }
    
    enum Action: Equatable {
        case searchLocationButtonTapped
        case zoomInButtonTapped
        case zoomOutButtonTapped
        case getDirectionsButtonTapped
        case currentLocationButtonTapped
        
        case searching(PresentationAction<SearchDestinationStore.Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .searchLocationButtonTapped:
                state.isShownSearchDestinationView = SearchDestinationStore.State() // 상태를 초기화
                return .none
                
            case .zoomInButtonTapped:
                return .none
                
            case .zoomOutButtonTapped:
                return .none
                
            case .getDirectionsButtonTapped:
                state.isDefectedArrowButtonVisible.toggle()
                return .none
                
            case .currentLocationButtonTapped:
                return .none
                
            case .searching: // 검색 중에 수행되는 일
                return .none
            }
        }
        .ifLet(\.$isShownSearchDestinationView, action: /Action.searching) {
            SearchDestinationStore()
        }
    }
}
