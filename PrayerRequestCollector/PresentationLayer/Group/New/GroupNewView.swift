//
//  GroupNewView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/23.
//

import SwiftUI
import ComposableArchitecture

struct GroupNewView: View {
    let store: StoreOf<GroupNewReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<GroupNewReducer>
    
    init(store: StoreOf<GroupNewReducer>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { state in
            return state
        })
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                memberNameTextField
                addMemberButton
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 20)
            
            memberList
            
            HStack(spacing: 5) {
                groupNameTextField
                addGroupButton
            }
        }
        
    }
    
    var memberNameTextField: some View {
        VStack {
            TextField("멤버 이름을 입력해주세요", text:
                viewStore.$inputMemberString)
                .textFieldStyle(.roundedBorder)
        }
    }
    
    var addMemberButton: some View {
        VStack {
            Button(action: {
                viewStore.send(.tapAddMemberButton)
            }, label: {
                Text("추가")
                    .frame(width: 40)
                    
            })
            .buttonStyle(.bordered)
        }
    }
    
    var memberList: some View {
        VStack {
            List(viewStore.members) { member in
                Text(member.name)
            }
        }
    }
    
    var groupNameTextField: some View {
        VStack {
            TextField("모임 이름을 입력해주세요", text: viewStore.$inputGroupString)
                .textFieldStyle(.roundedBorder)
        }
    }
    
    var addGroupButton: some View {
        VStack {
            Button(action: {
                viewStore.send(.tapAddGroupButton)
            }, label: {
                Text("모임 추가하기")
            })
            .buttonStyle(.bordered)
        }
        .padding(.all, 20)
    }
}
