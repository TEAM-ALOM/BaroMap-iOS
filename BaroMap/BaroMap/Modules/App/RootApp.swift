//
//  RootApp.swift
//  classPractice
//
//  Created by 이소리 on 11/10/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct RootApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootStore.State()) {
                    RootStore()
                        ._printChanges()
                }
            )
        }
    }
}
