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
    let createdDate: Date
    
    init(name: String, members: [Member] = [], date: Date = Date()) {
        self.name = name
        self.members = members
        self.createdDate = date
    }
}

extension Group: Equatable {
    
}
