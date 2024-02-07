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
        static func == (lhs: SearchMapResultStore.State, rhs: SearchMapResultStore.State) -> Bool {
             return true
        }
        
        var place: Place = Destination.shared.searching
        var isDetailViewActive = false
    }
    
    enum Action: Equatable {
        case goButtonTapped
        case setFromButtonTapped
        case setToButtonTapped
        case detailViewTapped(Bool)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .goButtonTapped: // des.cancelbutton 구현
                return .run { send in
                    if Destination.shared.type == .from {
                        await send(.setFromButtonTapped)
                    } else {
                        await send(.setToButtonTapped)
                    }
                }
                               
            case .setFromButtonTapped:
                Destination.shared.type = .from
                Destination.shared.from = state.place
                return .none
                
            case .setToButtonTapped:
                Destination.shared.type = .to
                Destination.shared.to = state.place
                return .none

            case let .detailViewTapped(isActive):
                state.isDetailViewActive = isActive
                return .none
            }
        }
    }
}

//Destination.shared.type.text -> "출발지명", "도착지명"
//Destination.shared.type.placeholder -> "출발지", "도착ㅈ
