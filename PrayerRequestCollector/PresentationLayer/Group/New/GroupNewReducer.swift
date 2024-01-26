//
//  GroupNewReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/23.
//

import Foundation
import ComposableArchitecture

struct GroupNewReducer: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        
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
