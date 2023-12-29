//
//  SearchLocationStore.swift
//  classPractice
//
//  Created by 이소리 on 11/10/23.
//

import Foundation
import ComposableArchitecture

struct SearchDestinationStore: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case cancelButtonTapped
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
