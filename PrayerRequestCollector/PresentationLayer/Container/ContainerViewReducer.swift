//
//  MainViewReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/09.
//

import Foundation
import ComposableArchitecture

struct ContainerViewReducer: Reducer {
    
    @Dependency(\.groupClient) var groupClient

    struct State: Equatable {
        var menuButtonMode: MenuSelectingMode = .notSelecting
        var presentedScreen: PresentedScreen = .home
    }
    
    enum Action: Equatable {
        case viewEvent(ViewEvent)
        case menuSelectEnable
        case tapMenuButton(CoordinateAction)
        case tapDimmedBackground
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .menuSelectEnable:
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
            case let .tapMenuButton(coordinateAction):
                print("### tap menu button")
                let changedMenuSelectingMode: State.MenuSelectingMode = {
                    switch state.menuButtonMode {
                    case .selecting:
                        return .notSelecting
                    case .notSelecting:
                        return .selecting
                    }
                }()
                
                state.menuButtonMode = changedMenuSelectingMode
                
                let presentedScreen: State.PresentedScreen = {
                    switch coordinateAction {
                    case .home:
                        return .home
                    case .group:
                        return .group
                    case .write:
                        return .write
                    case .search:
                        return .search
                    }
                }()
                
                state.presentedScreen = presentedScreen
                
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
        ._printChanges()
    }
}

// MARK: - Action
extension ContainerViewReducer.Action {
    enum ViewEvent {
        case onAppear
    }
    
    enum CoordinateAction {
        case home
        case group
        case write
        case search
    }
}

// MARK: - State
extension ContainerViewReducer.State {
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
