//
//  GroupDetailView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import SwiftUI
import ComposableArchitecture

struct GroupDetailView: View {
    let store: StoreOf<GroupDetailReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<GroupDetailReducer>
    
    init(store: StoreOf<GroupDetailReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    var body: some View {
        VStack {
            Text(viewStore.group.name)
        }
    }
}

//struct GroupDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            GroupDetailView(store: .init(initialState: .init(), reducer: {
//                GroupDetailReducer()
//            }))
//        }
//
//    }
//}
