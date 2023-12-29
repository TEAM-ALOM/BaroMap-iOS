//
//  HomeMainStore.swift
//  classPractice
//
//  Created by 이소리 on 12/27/23.
//

import Foundation
import ComposableArchitecture

struct HomeMainStore: Reducer {
    struct State: Equatable { }
    
    enum Action: Equatable {
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        default: return .none
        }
    }
}
