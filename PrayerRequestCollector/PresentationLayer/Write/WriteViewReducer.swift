//
//  WriteViewReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/09.
//

import Foundation
import ComposableArchitecture

struct WriteViewReducr: Reducer {
    
    @Dependency(\.groupClient) var groupClient
    
    struct State: Equatable {
        var rowReducers: IdentifiedArrayOf<WriteGroupRowReducer.State>
        var isListHidden: Bool = false
        var selectedGroup: Group?
    }
    
    enum Action: Equatable {
        enum ViewEvent: Equatable {
            case onAppear
        }
        
        case viewEvent(ViewEvent)
        case getGroups(TaskResult<[Group]>)
        case rowReducerAction(id: WriteGroupRowReducer.State.ID, action: WriteGroupRowReducer.Action)
        case tapMember(Member)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewEvent(.onAppear):
                return .run { send in
                    await send(.getGroups(await TaskResult {
                            try await self.groupClient.getGroups()
                        }
                    ))
                }
                
            case let .getGroups(.success(groups)):
                state.rowReducers = .init(IdentifiedArray(uniqueElements: groups.map {
                    .init(group: $0)
                }))
                return .none
            case let .tapMember(member):
                let selectedMember = state.selectedGroup?.members
                    .filter { $0.id == member.id }
                    .first
                
                guard var selectedMember = selectedMember else { return .none}
                
                selectedMember.checkState.toggle()
                return .none
                       
            case let .rowReducerAction(id, action):
                // row에 대한 액션 받는 부분
                switch action {
                case let .tapGroup(group):
                    state.selectedGroup = group
                    state.isListHidden = true
                    return .none
                    
                
                default:
                    return .none
                }
                
                

            default:
                return .none
            }
        }
        .forEach(\.rowReducers, action: /Action.rowReducerAction(id:action:)) {
            WriteGroupRowReducer()
        }
    }
}
