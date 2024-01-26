//
//  GroupDetailReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation
import ComposableArchitecture

struct GroupDetailReducer: Reducer {
    
    struct State: Equatable {
        let group: Group
        
        init(group: Group) {
            self.group = group
        }
        
        var id: String {
            group.id
        }
        
        var memberCount: String {
            String(group.members.count)
        }
    }
    
    enum Action: Equatable {
        case path
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
