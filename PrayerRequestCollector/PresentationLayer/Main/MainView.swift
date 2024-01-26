//
//  MainView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2023/12/01.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: StoreOf<MainViewReducer>
    let viewStore: ViewStoreOf<MainViewReducer>
    
    init(store: StoreOf<MainViewReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
        
        UITabBar.appearance().backgroundColor = UIColor.yellow.withAlphaComponent(0.1)
    }
    
    @State private var selectedTab = 0

    
    var body: some View {
        tabbar
    }
}

extension MainView {
    var tabbar: some View {
        TabView {
            groupView
            
            writeView
            
            searchView
        }
        .tint(Color.orange)
    }
    
    var groupView: some View {
        GroupView(store: Store(initialState: GroupViewReducer.State(rowReducers: .init()), reducer: {
            GroupViewReducer()
        }))
        .tabItem {
            Image(systemName: "person.2.fill")
            Text("모임")
        }
    }
    
    var writeView: some View {
        WriteView(store: Store(initialState: WriteViewReducr.State(), reducer: {
            WriteViewReducr()
        }))
        .tabItem {
            Image(systemName: "pencil.line")
            Text("작성")
        }
    }
    
    var searchView: some View {
        SearchView(store: Store(initialState: SearchViewReducer.State(), reducer: {
            SearchViewReducer()
        }))
        .tabItem {
            Image(systemName: "magnifyingglass")
            Text("검색")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(store: Store(initialState: MainViewReducer.State(), reducer: {
            MainViewReducer()
        }))
    }
}
