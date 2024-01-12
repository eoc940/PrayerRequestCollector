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
        Text("작성")
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(store: Store(initialState: WriteViewReducr.State(), reducer: {
            WriteViewReducr()
        }))
    }
}
