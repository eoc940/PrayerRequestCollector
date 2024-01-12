//
//  Group.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation

struct Group: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let members: [Member]
    
    init(name: String, members: [Member] = []) {
        self.name = name
        self.members = members
    }
}

extension Group: Equatable {
    
}
