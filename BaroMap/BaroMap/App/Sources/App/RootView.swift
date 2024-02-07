//
//  RootView.swift
//  classPractice
//
//  Created by 이소리 on 11/10/23.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<RootStore>
    
    var body: some View {
        SwitchStore(self.store) {
            switch $0 {
            case .mainTab:
                CaseLet(/RootStore.State.mainTab, action: RootStore.Action.mainTab) {
                    MainTabView(store: $0)
                }
            }
        }
    }
}

//#Preview {
//    RootView()
//}
