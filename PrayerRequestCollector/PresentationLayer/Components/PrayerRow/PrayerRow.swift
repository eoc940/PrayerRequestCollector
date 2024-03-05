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
        VStack(alignment: .leading, spacing: 20){
            HStack {
                Text(viewStore.memberName)
                    .font(.system(size: 18))
                Spacer()
                Text(viewStore.date)
                    .font(.system(size: 14))

            }
            Text(viewStore.content)
                .font(.system(size: 14))

        }
        .padding(.all, 20)
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    PrayerRow(store: .init(initialState: PrayerRowReducer.State(prayer: Prayer(memberName: "형근", content: "감사하기")), reducer: {
        PrayerRowReducer()
    }))
}
