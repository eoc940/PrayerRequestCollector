//
//  GroupDetailView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import SwiftUI
import ComposableArchitecture

struct GroupDetailView: View {
    let store: StoreOf<GroupDetailReducer>
    @ObservedObject
    var viewStore: ViewStoreOf<GroupDetailReducer>
    
    init(store: StoreOf<GroupDetailReducer>) {
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
            
            updateGroupButton
        }
        .onAppear {
            viewStore.send(.viewEvent(.onAppear))
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
        NavigationView {
            VStack {
                List {
                    ForEach(viewStore.members) { member in
                        Text(member.name)
                    }
                    .onDelete(perform: removeRow)
                    .onMove(perform: moveRow)
                }
            }.navigationBarItems(trailing: EditButton())
        }
        
    }
    
    var updateGroupButton: some View {
        VStack {
            Button(action: {
                viewStore.send(.tapUpdateGroupButton)
            }, label: {
                Text("수정하기")
            })
            .buttonStyle(.bordered)
            .disabled(viewStore.isUpdateGroupButtonDisabled)
        }
    }
}

extension GroupDetailView {
    func removeRow(at offsets: IndexSet) {
        viewStore.send(.deleteMember(offsets))
    }
    
    func moveRow(from source: IndexSet, to destination: Int) {
        viewStore.send(.moveMember(source, destination))
    }
}

//struct GroupDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            GroupDetailView(store: .init(initialState: .init(), reducer: {
//                GroupDetailReducer()
//            }))
//        }
//
//    }
//}
