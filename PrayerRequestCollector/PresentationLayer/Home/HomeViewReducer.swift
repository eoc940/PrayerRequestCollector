//
//  HomeViewReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import SwiftUI
import ComposableArchitecture

struct HomeViewReducer: Reducer {
    
    @Dependency(\.homeClient) var homeClient
    
    struct State: Equatable {
        var rowReducers: IdentifiedArrayOf<PrayerRowReducer.State>
    }
    
    enum Action: Equatable {
        case viewEvent(ViewEvent)
        case getPrayers(TaskResult<[Prayer]>)
        case rowReducerAction(id: PrayerRowReducer.State.ID, action: PrayerRowReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewEvent(.onAppear):
                return .run { send in
                    await send(.getPrayers(await TaskResult {
                        try await self.homeClient.getRandomPrayers()
                    }))
                }
            case let .getPrayers(.success(prayers)):
                
                state.rowReducers = .init(IdentifiedArray(uniqueElements: prayers.map {
                    .init(prayer: $0) }
                ))
                
                return .none
            default:
                return .none
            }
        }
        .forEach(\.rowReducers, action: /Action.rowReducerAction(id:action:)) {
            PrayerRowReducer()
        }
    }
    
}

// MARK: - Action
extension HomeViewReducer.Action {
    enum ViewEvent {
        case onAppear
    }
}
