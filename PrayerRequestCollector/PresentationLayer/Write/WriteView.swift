//
//  WriteView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/09.
//

import SwiftUI
import ComposableArchitecture

struct WriteView: View {
    let store: StoreOf<WriteViewReducr>
    @ObservedObject
    var viewStore: ViewStoreOf<WriteViewReducr>
    
    init(store: StoreOf<WriteViewReducr>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    
    var body: some View {
        VStack {
            groupList
            membersView
        }
        .onAppear {
            viewStore.send(.viewEvent(.onAppear))
        }
    }
    
    var groupList: some View {
        VStack {
            if !viewStore.isListHidden {
                List {
                    ForEachStore(self.store.scope(state: \.rowReducers, action: WriteViewReducr.Action.rowReducerAction(id:action:))) { store in
                        WriteGroupRow(store: store)
                    }
                }
            }
        }
    }
    
    var membersView: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewStore.selectedGroup?.members ?? []) { member in
                    Button(action: {
                        
                    }, label: {
                        Text(member.name)
                    })
                }
            }
            
        }
    }
}



//
//struct WriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        WriteView(store: Store(initialState: WriteViewReducr.State(), reducer: {
//            WriteViewReducr()
//        }))
//    }
//}
