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
            
            menuButtonsView

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
    
    var menuButtonsView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 20) {
                    if viewStore.menuButtonMode == .selecting {
                        MenuButton(imageName: "pencil") {
                            viewStore.send(.tapMenuButton(.group))
                        }
                        MenuButton(imageName: "pencil.circle") {
                            viewStore.send(.tapMenuButton(.write))
                        }
                        MenuButton(imageName: "pencil.circle.fill") {
                            viewStore.send(.tapMenuButton(.search))
                        }
                    }
                    
                    MenuButton(imageName: "plus") {
                        viewStore.send(.tapMenuButton(.home))
                    }
                }
                .padding(.bottom, 20)
                .padding(.trailing, 20)
                .transition(.move(edge: .bottom))
                
                
            }
            
            
        }
        .onAppear { // root view에 onappear를 설정하면 navigation pop된 이후 안불림
            //viewStore.send(.viewEvent(.onAppear))
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
