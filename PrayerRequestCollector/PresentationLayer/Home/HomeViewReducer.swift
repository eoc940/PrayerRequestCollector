//
//  HomeViewReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import SwiftUI
import ComposableArchitecture

struct HomeViewReducer: Reducer {
    
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        enum ViewEvent {
            case onAppear
        }
        
        case viewEvent(ViewEvent)
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            default:
                return .none
            }
        }
    }
    
}
