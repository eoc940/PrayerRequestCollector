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

// MARK: - State
extension GroupRowReducer.State {
    var id: String {
        group.id
    }
    
    var memberCount: String {
        String(group.members.count)
    }
}
