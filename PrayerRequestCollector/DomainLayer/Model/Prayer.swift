//
//  Prayㄷㄱ.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import Foundation

struct Prayer: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let memberName: String
    let content: String
    let createdDate: Date
    
    init(memberName: String, content: String, date: Date = Date()) {
        self.memberName = memberName
        self.content = content
        self.createdDate = date
    }
}
