//
//  MemberView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/09.
//

import SwiftUI
import ComposableArchitecture

struct GroupView: View {
    let store: StoreOf<GroupViewReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<GroupViewReducer>
    
    init(store: StoreOf<GroupViewReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    var body: some View {
        VStack {
            Text("모임 관리")
                .font(Font.headline.bold())
            groupList
        }
        .onAppear {
            viewStore.send(.viewEvent(.onAppear))
        }
    }
    
    var groupList: some View {
        VStack {
            List {
                ForEachStore(self.store.scope(state: \.rowReducers, action: GroupViewReducer.Action.rowReducerAction(id: action:))) { store in
                    GroupRow(store: store)
                }
            }
            
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(store: Store(initialState: GroupViewReducer.State(rowReducers: .init()), reducer: {
            GroupViewReducer()
        }))
    }
}
