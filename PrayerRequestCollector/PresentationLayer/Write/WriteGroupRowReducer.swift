//
//  WriteGroupRowReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2/13/24.
//

import Foundation
import ComposableArchitecture

struct WriteGroupRowReducer: Reducer {
    struct State: Equatable, Identifiable {
        let group: Group
        
        init(group: Group) {
            self.group = group
        }
        
        var id: String {
            group.id
        }
        
        var members: [Member] {
            group.members
        }
        
        var memberCount: String {
            String(group.members.count)
        }
    }
    
    enum Action: Equatable {
        case tapGroup(Group)
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
