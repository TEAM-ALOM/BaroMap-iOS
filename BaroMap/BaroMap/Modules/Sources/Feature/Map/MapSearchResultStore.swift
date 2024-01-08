//
//  MapSearchResultStore.swift
//  BaroMap
//
//  Created by 이소리 on 1/5/24.
//

import Foundation
import ComposableArchitecture

struct MapSearchResultStore: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case pathfindingButtonTapped
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .pathfindingButtonTapped:
                return .none
            }
        }
    }
}
