//
//  MainTabView.swift
//  classPractice
//
//  Created by 이소리 on 12/27/23.
//

import SwiftUI
import ComposableArchitecture

struct MainTabView: View {
    let store: StoreOf<MainTabViewStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView {
                HomeMainView(store: self.store.scope(state: \.home, action: { .home($0) }))
                    .tabItem {
                      Image(systemName: "house.fill")
                      Text("홈")
                    }
                
                SearchLocationView(store: self.store.scope(state: \.searchMap, action: { .searchMap($0) }))
                    .tabItem {
                      Image(systemName: "map.fill")
                      Text("지도")
                    }
                
                MenuView(store: self.store.scope(state: \.menu, action: { .menu($0) }))
                    .tabItem {
                      Image(systemName: "line.3.horizontal")
                      Text("메뉴")
                    }
            }
        }
    }
}

//#Preview {
//    MainTabView()
//}
