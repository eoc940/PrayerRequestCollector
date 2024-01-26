//
//  GroupNewView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/23.
//

import SwiftUI
import ComposableArchitecture

struct GroupNewView: View {
    let store: StoreOf<GroupNewReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<GroupNewReducer>
    
    init(store: StoreOf<GroupNewReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    var body: some View {
        VStack {
            Text("추가")
        }
    }
}
