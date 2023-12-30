//
//  RootStore.swift
//  classPractice
//
//  Created by 이소리 on 11/10/23.
//

import Foundation
import ComposableArchitecture

struct RootStore: Reducer {

    enum State: Equatable {
        case mainTab(MainTabViewStore.State)
        
        init() {
            self = .mainTab(.init())
        }
    }
    
    enum Action: Equatable {
        case mainTab(MainTabViewStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
        
        .ifCaseLet(/State.mainTab, action: /Action.mainTab) {
            MainTabViewStore()
        }
    }
}

