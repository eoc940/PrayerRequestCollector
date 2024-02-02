//
//  GroupDetailReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation
import ComposableArchitecture

struct GroupDetailReducer: Reducer {
    
    @Dependency(\.groupClient) var groupClient
    
    struct State: Equatable {
        var group: Group
        
        var members: [Member] = []
        @BindingState var inputMemberString: String = ""
        var savedInputMemberString: String = ""
        var savedAllMembers: [Member] = []
        
        init(group: Group) {
            self.group = group
        }
        
        var isUpdateGroupButtonDisabled: Bool {
            group.members == members
        }
        
        var id: String {
            group.id
        }
        
        var memberCount: String {
            String(group.members.count)
        }
        
    }
    
    enum Action: BindableAction, Equatable {
        enum ViewEvent {
            case onAppear
            case onDisappear
        }
        case viewEvent(ViewEvent)
        case binding(BindingAction<State>)
        case tapAddMemberButton
        case tapUpdateGroupButton
        case path
        case popGroupDetailView
        case deleteMember(IndexSet)
        case moveMember(IndexSet, Int)
        case getAllMembers(TaskResult<[Member]>)
        case updateGroup(TaskResult<[Group]>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .viewEvent(.onAppear):
                state.members = state.group.members

                return .merge(
                    .run { send in
                        await(send(.getAllMembers(await
                            TaskResult {
                            try await self.groupClient.getAllMembers()
                            }
                        )))
                    }
                )
            case .binding(\.$inputMemberString):
                state.savedInputMemberString = state.inputMemberString
                return .none
            case let .deleteMember(indexSet):
                state.members.remove(atOffsets: indexSet)
                return .none
            case let .moveMember(indexSet, dest):
                state.members.move(fromOffsets: indexSet, toOffset: dest)
                return .none
            case .tapAddMemberButton:
                let name = state.savedInputMemberString
                // validation 로직 -> 같은 멤버면 alert, 다른 모임에 있다면 확인하는 절차 추가
                let trimming = name.trimmingCharacters(in: .whitespaces)
                
                let isNotEmptyString = !name.isEmpty

                let isAddEnableInAllGroup = state.savedAllMembers
                    .map { $0.name }
                    .filter { name in
                        name == trimming
                    }
                    .isEmpty
                
                let isAddEnableInsideGroup = state.members
                    .map { $0.name }
                    .filter { name in
                        name == trimming
                    }
                    .isEmpty
                
                if isNotEmptyString && isAddEnableInAllGroup && isAddEnableInsideGroup {
                    state.members.append(Member(name: name))
                } else {
                    // 다른 모임에 있다면 확인하는 절차 추가
                }
                
                return .none
            case .tapUpdateGroupButton:
                state.group.updateMembers(state.members)
                let group = state.group
                return .run { send in
                    await(send(.updateGroup(await
                        TaskResult {
                            try await self.groupClient.updateGroup(group)
                        }
                    )))
                }
            case let .getAllMembers(.success(savedAllMembers)):
                state.savedAllMembers = savedAllMembers
                return .none
            case .updateGroup(.success(_)):
                return .run { send in
                    await send(.popGroupDetailView)
                }
            default:
                return .none
            }
            
        }
    }
}
