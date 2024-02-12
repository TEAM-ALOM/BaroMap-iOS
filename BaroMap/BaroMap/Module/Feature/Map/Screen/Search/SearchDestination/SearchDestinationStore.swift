//
//  SearchLocationStore.swift
//  BaroMap
//
//  Created by 이소리 on 11/10/23.
//

import Foundation
import ComposableArchitecture

struct SearchDestinationStore: Reducer {
    struct State: Equatable {
        var title: PlaceSearchType
        var userInput: String = ""
        var placeName: String = ""
        var placeAddress: String = ""
        var isDetailActive: Bool = false
        var searchMapResult = SearchMapResultStore.State(type: .searching, placeName: "", placeAddress: "")
    }
        
    enum Action: Equatable {
        case onAppear
        case updateText(String)
        case cancelButtonTapped
        case detailButtonTapped
        case searchMapResult(SearchMapResultStore.Action)
    }
    
    @Dependency(\.dismiss) var dismiss

    var body: some Reducer<State, Action> {
        Scope(state: \State.searchMapResult, action: /Action.searchMapResult) {
            SearchMapResultStore()
                ._printChanges()
        }
        
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }
                
            case .updateText(let text):
                state.userInput = text
                
                state.placeName = text
                state.placeAddress = "강남어딘가"
                return .none
                
            case .detailButtonTapped:
                state.isDetailActive = true
                return .none
                
            case .searchMapResult(.onAppear):
                state.searchMapResult.type = state.title
                state.searchMapResult.placeName = state.placeName
                state.searchMapResult.placeAddress = state.placeAddress
                return .none
                
            default:
                return .none
            }
        }
    }
}
