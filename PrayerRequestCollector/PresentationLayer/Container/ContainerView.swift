//
//  MainView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2023/12/01.
//

import SwiftUI
import ComposableArchitecture

struct ContainerView: View {
    let store: StoreOf<ContainerViewReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<ContainerViewReducer>
    
    init(store: StoreOf<ContainerViewReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    let homeView = HomeView(store: .init(initialState: HomeViewReducer.State(rowReducers: .init()), reducer: {
        HomeViewReducer()
    }))
    
    let groupView = GroupView(store: .init(initialState: GroupViewReducer.State(rowReducers: .init()), reducer: {
        GroupViewReducer()
    }))
    
    let writeView = WriteView(store: .init(initialState: WriteViewReducr.State(rowReducers: .init()), reducer: {
        WriteViewReducr()
    }))
    
    let searchView = SearchView(store: .init(initialState: SearchViewReducer.State(), reducer: {
        SearchViewReducer()
    }))

    var body: some View {
        ZStack {
            
            presentedView
            
            dimmedView
            
            menuButtonsView

        }
    }
}

extension ContainerView {
    var presentedView: some View {
        VStack {
            switch viewStore.presentedScreen {
            case .home:
                let _ = print("### home present")
                homeView
            case .group:
                let _ = print("### group present")
                groupView
                
            case .write:
                let _ = print("### write present")
                writeView
                
            case .search:
                let _ = print("### search present")
                searchView
                
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
                        
                        MenuButton(imageName: "plus") {
                            viewStore.send(.tapMenuButton(.home))
                        }
                    } else {
                        MenuButton(imageName: "plus", backgroundColor: Color.gray) {
                            viewStore.send(.menuSelectEnable)
                        }
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
        ContainerView(store: Store(initialState: ContainerViewReducer.State(), reducer: {
            ContainerViewReducer()
        }))
    }
}
