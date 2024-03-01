//
//  PrayerRowReducer.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import Foundation
import ComposableArchitecture

struct PrayerRowReducer: Reducer {

    struct State: Equatable, Identifiable {
        let prayer: Prayer
        
        init(prayer: Prayer) {
            self.prayer = prayer
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

// MARK: - State
extension PrayerRowReducer.State {
    var id: String {
        prayer.id
    }
    
    var memberName: String {
        prayer.memberName
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let dateString = formatter.string(from: prayer.createdDate)
        
        return dateString
    }
    
    var content: String {
        prayer.content
    }
}
