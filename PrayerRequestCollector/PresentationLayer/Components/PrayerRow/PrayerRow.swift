//
//  PrayerRow.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import SwiftUI
import ComposableArchitecture

struct PrayerRow: View {
    let store: StoreOf<PrayerRowReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<PrayerRowReducer>
    
    init(store: StoreOf<PrayerRowReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewStore.memberName)
                Spacer()
                Text(viewStore.date)
            }
            Text(viewStore.content)
        }
        .background(Color.white)
    }
}

#Preview {
    PrayerRow(store: .init(initialState: PrayerRowReducer.State(prayer: Prayer(memberName: "형근", content: "감사하기")), reducer: {
        PrayerRowReducer()
    }))
}
