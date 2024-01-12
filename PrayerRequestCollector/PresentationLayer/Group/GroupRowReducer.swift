//
//  GroupRowReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation
import ComposableArchitecture

struct GroupRowReducer: Reducer {
    
    struct State: Equatable, Identifiable {
        
        
        let group: Group
        
        init(group: Group) {
            self.group = group
        }
        
        var id: String {
            group.id
        }
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
