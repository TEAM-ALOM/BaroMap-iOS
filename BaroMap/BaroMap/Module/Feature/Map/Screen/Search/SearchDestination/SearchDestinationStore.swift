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
        var setTitle = SearchLocationStore.State()
        var type: PlaceSearchType = .searching
        var title: String { return type.placeholder }
        var text: String = ""
    }
        
    enum Action: Equatable {
        case onAppear
        case setTitle(SearchLocationStore.Action)
        case updateText(String)
        case cancelButtonTapped
        case detailButtonTapped(Bool)
    }
    
    @Dependency(\.dismiss) var dismiss

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state = .init()
                return .none

            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }
                
            case .setTitle(.searching):
                state.type = .searching
                return .none
                
            case .setTitle(.from):
                state.type = .from
                return .none
                
            case .setTitle(.to):
                state.type = .to
                return .none
                
            case .updateText:
                return .none
                
            case .detailButtonTapped(true):
                return .none
                
            default:
                return .none
            }
        }
        Scope(state: \State.setTitle, action: /Action.setTitle) {
            SearchLocationStore()
                ._printChanges()
        }
    }
}
