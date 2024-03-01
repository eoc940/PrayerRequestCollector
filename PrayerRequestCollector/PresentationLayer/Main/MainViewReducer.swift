//
//  MainViewReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/09.
//

import Foundation
import ComposableArchitecture

struct MainViewReducer: Reducer {
    
    @Dependency(\.groupClient) var groupClient

    struct State: Equatable {
        var menuButtonMode: MenuSelectingMode = .notSelecting
        var presentedScreen: PresentedScreen = .home
    }
    
    enum Action: Equatable {
        enum ViewEvent {
            case onAppear
        }
        
        case viewEvent(ViewEvent)
        case tapMenuButton
        case tapDimmedBackground
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tapMenuButton:
                let changedMenuSelectingMode: State.MenuSelectingMode = {
                    switch state.menuButtonMode {
                    case .selecting:
                        return .notSelecting
                    case .notSelecting:
                        return .selecting
                    }
                }()

                state.menuButtonMode = changedMenuSelectingMode
                return .none
            case .tapDimmedBackground:
                if state.menuButtonMode == .selecting {
                    state.menuButtonMode = .notSelecting
                }
                return .none
            default:
                return .none
            }
        }
    }
}

extension MainViewReducer.State {
    enum MenuSelectingMode: Equatable {
        case selecting
        case notSelecting
    }
    
    enum PresentedScreen: Equatable {
        case home
        case group
        case write
        case search
    }
}
