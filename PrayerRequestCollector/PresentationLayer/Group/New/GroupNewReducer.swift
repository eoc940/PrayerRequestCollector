//
//  GroupNewReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/23.
//

import Foundation
import ComposableArchitecture

struct GroupNewReducer: Reducer {
    
    @Dependency(\.groupClient) var groupClient
    
    struct State: Equatable {
        @BindingState var inputMemberString: String = ""
        @BindingState var inputGroupString: String = ""
        var savedInputMemberString: String = ""
        var savedInputGroupString: String = ""
        var savedAllMembers: [Member] = []
        var members: [Member] = []
    }
    
    enum Action: BindableAction, Equatable {
        enum ViewEvent {
            case onAppear
            case onDisappear
        }
        case viewEvent(ViewEvent)
        case binding(BindingAction<State>)
        case tapAddMemberButton
        case tapAddGroupButton
        case postGroup(TaskResult<[Group]>)
        case popGroupNewView
        case getAllMembers(TaskResult<[Member]>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .viewEvent(.onAppear):
                
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
            case .binding(\.$inputGroupString):
                state.savedInputGroupString = state.inputGroupString
                return .none
            case .tapAddMemberButton:
                let name = state.savedInputMemberString
                // validation 로직 -> 같은 멤버면 alert, 다른 모임에 있다면 확인하는 절차 추가
                let trimming = name.trimmingCharacters(in: .whitespaces)
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
                
                if isAddEnableInAllGroup && isAddEnableInsideGroup {
                    state.members.append(Member(name: name))
                } else {
                    // 다른 모임에 있다면 확인하는 절차 추가
                }
                
                
                return .none
            case .tapAddGroupButton:
                let members = state.members
                let groupName = state.savedInputGroupString
                if groupName.trimmingCharacters(in: .whitespaces).isEmpty {
                    // alert 띄워야함
                    return .none
                }
                let group = Group(name: groupName, members: members)
                return .run { send in
                    await send(.postGroup(await
                        TaskResult {
                            try await groupClient.addGroup(group)
                        })
                    )
                }
            case .postGroup(.success(let groups)):
                let _ = groups
                return .run { send in
                    await send(.popGroupNewView)
                }
            case let .getAllMembers(.success(savedAllMembers)):
                state.savedAllMembers = savedAllMembers
                return .none
            default:
                return .none
            }
        }
    }
}

extension GroupNewReducer {
    
}
