//
//  SearchLocationStore.swift
//  BaroMap
//
//  Created by 이소리 on 11/10/23.
//
//test


import Foundation
import ComposableArchitecture

struct SearchLocationStore: Reducer {
        
    struct State: Equatable {
        @PresentationState var isShownSearchDestinationView: SearchDestinationStore.State?
        
        public var departure: String = ""
        public var arrival: String = ""
        var useFromToBox: Bool = true
        var isLocationTracking: Bool = true
    }
    
    enum Action: Equatable {
        case searchLocationButtonTapped
        case zoomInButtonTapped
        case zoomOutButtonTapped
        case getDirectionsButtonTapped
        case myLocationButtonTapped
        
        case searching(PresentationAction<SearchDestinationStore.Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .searchLocationButtonTapped:
                Destination.shared.placeholder = "장소"
                Destination.shared.isLocationSearch = true
                
                state.isShownSearchDestinationView = SearchDestinationStore.State() // 상태를 초기화
                return .none
                
            case .zoomInButtonTapped:
                return .none
                
            case .zoomOutButtonTapped:
                return .none
                
            case .getDirectionsButtonTapped:
                state.useFromToBox.toggle()
                return .none
                
            case .myLocationButtonTapped:
                state.isLocationTracking.toggle()
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
