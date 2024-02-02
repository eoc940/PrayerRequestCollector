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

    struct Path: Reducer {
        enum State: Equatable {
            case new(GroupNewReducer.State)
            case detail(GroupDetailReducer.State)
        }
        
        enum Action: Equatable {
            case new(GroupNewReducer.Action)
            case detail(GroupDetailReducer.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: /State.new, action: /Action.new) {
                GroupNewReducer()
            }
            Scope(state: /State.detail, action: /Action.detail) {
                GroupDetailReducer()
            }
        }
    }
    
    struct State: Equatable {
        var rowReducers: IdentifiedArrayOf<GroupRowReducer.State>
        var path = StackState<Path.State>()
    }
    
    enum Action: Equatable {
        
        enum ViewEvent: Equatable {
            case onAppear
        }

        case path(StackAction<Path.State, Path.Action>)
        case viewEvent(ViewEvent)
        case getGroups(TaskResult<[Group]>)
        case tapAddButton
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
            case .tapAddButton:
                state.path.append(.new(.init()))
                return .none
            case let .getGroups(.success(groups)):
                state.rowReducers = .init(IdentifiedArray(uniqueElements: groups.map { .init(group: $0) }
                ))
                    
                return .none
            case .path(let action):
                switch action {
                case .element(id: _, action: .new(.popGroupNewView)):
                    _ = state.path.popLast()
                    return .none
                case .element(id: _, action: .detail(.popGroupDetailView)):
                    // popTo(id)를 사용해봐도 좋을듯
                    _ = state.path.popLast()
                    return .none
                default:
                    return .none
                }
            default:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}

