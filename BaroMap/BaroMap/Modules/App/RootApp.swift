//
//  RootApp.swift
//  BaroMap
//
//  Created by 이소리 on 11/21/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct RootApp: App {
    var body: some Scene {
        WindowGroup {
            SearchLocationView(
                store: Store(initialState: SearchLocationStore.State()) {
                    SearchLocationStore()
                        ._printChanges()
                }
            )
        }
    }
}
