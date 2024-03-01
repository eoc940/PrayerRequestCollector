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
    @ObservedObject
    var viewStore: ViewStoreOf<MainViewReducer>
    
    init(store: StoreOf<MainViewReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }

    var body: some View {
        ZStack {
            
            presentedView
            
            dimmedView
            
            menuButton

        }
    }
}

extension MainView {
    var presentedView: some View {
        VStack {
            switch viewStore.presentedScreen {
            case .home:
                HomeView(store: .init(initialState: HomeViewReducer.State(), reducer: {
                    HomeViewReducer()
                }))
            case .group:
                GroupView(store: .init(initialState: GroupViewReducer.State(rowReducers: .init()), reducer: {
                    GroupViewReducer()
                }))
            case .write:
                WriteView(store: .init(initialState: WriteViewReducr.State(rowReducers: .init()), reducer: {
                    WriteViewReducr()
                }))
            case .search:
                SearchView(store: .init(initialState: SearchViewReducer.State(), reducer: {
                    SearchViewReducer()
                }))
            }
        }
    }
    
    var dimmedView: some View {
        VStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea(edges: .all)
                .onTapGesture {
                    viewStore.send(.tapDimmedBackground)
                }
        }
        .hidden(viewStore.menuButtonMode == .notSelecting)
        
    }
    
    var menuButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewStore.send(.tapMenuButton)
                }, label: {
                    Image(systemName: "plus")
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white))
                        .shadow(radius: 5)
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                })
            }
        }
        .onAppear { // root view에 onappear를 설정하면 navigation pop된 이후 안불림
            //viewStore.send(.viewEvent(.onAppear))
        }
    }
    
//    var groupView: some View {
//        GroupView(store: Store(initialState: GroupViewReducer.State(rowReducers: .init()), reducer: {
//            GroupViewReducer()
//        }))
//        .tabItem {
//            Image(systemName: "person.2.fill")
//            Text("모임")
//        }
//    }
//    
//    var writeView: some View {
//        WriteView(store: Store(initialState: WriteViewReducr.State(rowReducers: .init()), reducer: {
//            WriteViewReducr()
//        }))
//        .tabItem {
//            Image(systemName: "pencil.line")
//            Text("작성")
//        }
//    }
//    
//    var searchView: some View {
//        SearchView(store: Store(initialState: SearchViewReducer.State(), reducer: {
//            SearchViewReducer()
//        }))
//        .tabItem {
//            Image(systemName: "magnifyingglass")
//            Text("검색")
//        }
//    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(store: Store(initialState: MainViewReducer.State(), reducer: {
            MainViewReducer()
        }))
    }
}
