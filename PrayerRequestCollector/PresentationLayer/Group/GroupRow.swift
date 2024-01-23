//
//  GroupRow.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import SwiftUI
import ComposableArchitecture

struct GroupRow: View {
    let store: StoreOf<GroupRowReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<GroupRowReducer>
    
    init(store: StoreOf<GroupRowReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewStore.group.name)
                Spacer()
                Text(viewStore.memberCount)
            }
        }
    }
}
