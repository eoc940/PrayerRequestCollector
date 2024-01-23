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
        var path = StackState<GroupDetailReducer.State>()
        //    @PresentationState var destination: Destination.State?
            
    }
    
    enum Action: Equatable {
        
        enum ViewEvent: Equatable {
            case onAppear
        }
//        case destination(PresentationAction<Destination.Action>)
        case path(StackAction<GroupDetailReducer.State, GroupDetailReducer.Action>)
        case viewEvent(ViewEvent)
        case getGroups(TaskResult<[Group]>)
        case tapAddButton
        case rowReducerAction(id: GroupRowReducer.State.ID, action: GroupRowReducer.Action)
        case pushToDetail(Group)
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
                
                return .none
            case let .getGroups(.success(groups)):
                state.rowReducers = .init(IdentifiedArray(uniqueElements: groups.map { .init(group: $0) }
                ))
                    
                return .none
            case .path:
                return .none
            default:
                return .none
            }
        }
//        .ifLet(\.$destination, action: \.destination) {
//            Destination()
//        }
        .forEach(\.path, action: /Action.path) {
            GroupDetailReducer()
        }
    }
}

