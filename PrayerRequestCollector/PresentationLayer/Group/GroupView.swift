//
//  MemberView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/09.
//

import SwiftUI
import ComposableArchitecture

struct GroupView: View {
    let store: StoreOf<GroupViewReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<GroupViewReducer>
    
    init(store: StoreOf<GroupViewReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    var body: some View {
        VStack {
            groupList
        }
        .background(Color.gray.opacity(0.1))
        
    }
    
    var groupList: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: { childAction in
                .path(childAction)
        })) {
            ZStack {
                List {
                    ForEachStore(self.store.scope(state: \.rowReducers, action: GroupViewReducer.Action.rowReducerAction(id: action:))) { store in
                        let rowState = store.withState { $0 }
                        // i don't know here1
                        NavigationLink(state: GroupViewReducer.Path.State.detail(.init(group: rowState.group))) {
                            GroupRow(store: store)
                        }
                        
                    }
                }
                .background(Color.gray.opacity(0.1))
                .scrollContentBackground(.hidden)
                
                groupAddButton
                    
            }
        } destination: { state in
            switch state {
            case .new:
                CaseLet(
                    /GroupViewReducer.Path.State.new,
                     action: GroupViewReducer.Path.Action.new,
                     then: GroupNewView.init(store:)
                )
            case .detail:
                CaseLet(
                    /GroupViewReducer.Path.State.detail,
                     action: GroupViewReducer.Path.Action.detail,
                     then: GroupDetailView.init(store:)
                )
            }
        }
    }
    
    var groupAddButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    // i don't know here2
                    viewStore.send(.tapAddButton)
                }, label: {
                    Image(systemName: "plus")
                        .frame(width: 40, height: 40) // 이미지 크기 설정
                        .clipShape(Circle()) // 이미지를 원 모양으로 클리핑
                        .overlay(Circle().stroke(Color.white)) // 원 주위에 흰색 테두리 추가
                        .shadow(radius: 5) // 그림자 효과 추가
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                })
            }
        }
        .onAppear { // root view에 onappear를 설정하면 navigation pop된 이후 안불림
            viewStore.send(.viewEvent(.onAppear))
        }
    }
}
