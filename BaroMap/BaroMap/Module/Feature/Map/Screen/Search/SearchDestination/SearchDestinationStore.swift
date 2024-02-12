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
        let title: String
        var text: String = ""
    }
        
    enum Action: Equatable {
        case onAppear
        case updateText(String)
        case cancelButtonTapped
        case detailButtonTapped(Bool)
    }
    
    @Dependency(\.dismiss) var dismiss

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .run { _ in await self.dismiss() }
                
            case .updateText(let text):
                state.text = text
                return .none
                
            case .detailButtonTapped(true):
                return .none
                
            default:
                return .none
            }
        }
    }
}
