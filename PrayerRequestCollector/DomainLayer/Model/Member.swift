//
//  Member.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation

struct Member: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let name: String
    var checkState: Bool = false
    
    init(name: String) {
        self.name = name
    }
}

extension Member: Equatable {
    
}
