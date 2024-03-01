//
//  WriteGroupRow.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2/13/24.
//

import SwiftUI
import ComposableArchitecture

struct WriteGroupRow: View {
    let store: StoreOf<WriteGroupRowReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<WriteGroupRowReducer>
    
    init(store: StoreOf<WriteGroupRowReducer>) {
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
        .contentShape(Rectangle())
        .onTapGesture {
            viewStore.send(.tapGroup(viewStore.group))
        }
    }
}

//#Preview {
//    WriteGroupRow()
//}
