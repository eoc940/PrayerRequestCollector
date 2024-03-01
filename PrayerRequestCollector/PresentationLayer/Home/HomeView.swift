//
//  HomeView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<HomeViewReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<HomeViewReducer>
    
    init(store: StoreOf<HomeViewReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    var body: some View {
        VStack {
            prayerListView
        }
        .onAppear {
            viewStore.send(.viewEvent(.onAppear))
        }
    }

    var prayerListView: some View {
        VStack {
            List {
                ForEachStore(self.store.scope(state: \.rowReducers, action: HomeViewReducer.Action.rowrReducerAction(id: action:))) { store in
                    PrayerRow(store: store)
                }
            }
        }
    }
}
