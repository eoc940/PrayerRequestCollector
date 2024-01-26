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
        var members: [Member] = []
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case tapAddMemberButton
        case tapAddGroupButton
        case postGroup(TaskResult<[Group]>)
        case popGroupNewView
        
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                
            case .binding(\.$inputMemberString):
                state.savedInputMemberString = state.inputMemberString
                return .none
            case .binding(\.$inputGroupString):
                state.savedInputGroupString = state.inputGroupString
                return .none
            case .tapAddMemberButton:
                let name = state.savedInputMemberString
                // validation 로직 -> 같은 멤버면 alert, 다른 모임에 있다면 확인하는 절차 추가
                state.members.append(Member(name: name))
                return .none
            case .tapAddGroupButton:
                let members = state.members
                let groupName = state.savedInputGroupString
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
            default:
                return .none
            }
        }
    }
}

extension GroupNewReducer {
    
}
