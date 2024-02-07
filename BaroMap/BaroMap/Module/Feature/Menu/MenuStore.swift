//
//  MenuStore.swift
//  classPractice
//
//  Created by 이소리 on 12/27/23.
//

import Foundation
import ComposableArchitecture

struct MenuStore: Reducer {
    struct State: Equatable { }
    
    enum Action: Equatable {
        case tmp
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tmp: return .none
            }
        }
    }
}
