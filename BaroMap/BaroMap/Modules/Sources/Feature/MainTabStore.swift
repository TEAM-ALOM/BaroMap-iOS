//
//  MainTabStore.swift
//  classPractice
//
//  Created by 이소리 on 12/27/23.
//

import Foundation
import ComposableArchitecture

enum MainScene: Hashable {
    case home
    case searchMap
    case menu
}

struct MainTabViewStore: Reducer {

    struct State: Equatable {
        var currentScene: MainScene = .home
        
        var home: HomeMainStore.State = .init()
        var searchMap: SearchLocationStore.State = .init(placeholder: "장소") // ??
        var menu: MenuStore.State = .init()
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case selectTab(MainScene)
        
        case home(HomeMainStore.Action)
        case searchMap(SearchLocationStore.Action)
        case menu(MenuStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
        
        Scope(state: \.home, action: /Action.home) {
            HomeMainStore()._printChanges()
        }
        
        Scope(state: \.searchMap, action: /Action.searchMap) {
            SearchLocationStore()._printChanges()
        }
        
        Scope(state: \.menu, action: /Action.menu) {
            MenuStore()._printChanges()
        }
    }
}
