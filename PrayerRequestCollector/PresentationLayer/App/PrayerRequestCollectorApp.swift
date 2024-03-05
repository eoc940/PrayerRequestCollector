//
//  PrayerRequestCollectorApp.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2023/12/01.
//

import SwiftUI
import ComposableArchitecture

@main
struct PrayerRequestCollectorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContainerView(store: Store(initialState: ContainerViewReducer.State(), reducer: {
                ContainerViewReducer()
            }))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
