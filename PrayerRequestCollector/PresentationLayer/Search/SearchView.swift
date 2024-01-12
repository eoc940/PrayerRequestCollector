//
//  SearchView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/09.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    let store: StoreOf<SearchViewReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<SearchViewReducer>
    
    init(store: StoreOf<SearchViewReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    
    
    
    var body: some View {
        Text("찾기")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(store: Store(initialState: SearchViewReducer.State(), reducer: {
            SearchViewReducer()
        }))
    }
}
