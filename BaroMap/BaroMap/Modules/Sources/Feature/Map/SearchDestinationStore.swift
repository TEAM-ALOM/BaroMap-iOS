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
        var isDetailViewActive = false
    }
    
    enum Action: Equatable {
        case cancelButtonTapped
        case toggleDetailView(Bool)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }
                
            case let .toggleDetailView(isActive):
                state.isDetailViewActive = isActive
                return .none
            }
        }
    }
}
