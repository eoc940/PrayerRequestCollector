//
//  GroupViewReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/09.
//

import Foundation
import ComposableArchitecture

struct GroupViewReducer: Reducer {
    
    @Dependency(\.groupClient) var groupClient
    
    struct State: Equatable {
        var rowReducers: IdentifiedArrayOf<GroupRowReducer.State>
    }
    
    enum Action: Equatable {
        
        enum ViewEvent: Equatable {
            case onAppear
        }
        
        case viewEvent(ViewEvent)
        case getGroups(TaskResult<[Group]>)
        case rowReducerAction(id: GroupRowReducer.State.ID, action: GroupRowReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewEvent(.onAppear):
                return .run { send in
                    await send(.getGroups(await
                        TaskResult {
                            try await self.groupClient.getGroups()
                        }
                    ))
                }
            case let .getGroups(.success(groups)):
                state.rowReducers = .init(IdentifiedArray(uniqueElements: groups.map { .init(group: $0) }
                ))
                    
                
                
                return .none
            default:
                return .none
            }
        }
    }
}

