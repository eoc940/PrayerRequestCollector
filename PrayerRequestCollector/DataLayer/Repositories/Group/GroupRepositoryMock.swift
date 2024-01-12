//
//  GroupRepositoryMock.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation

struct GroupRepositoryMock: GroupRepositoryProtocol {
    func getGroups() -> [Group] {
        let groups: [Group] = [
            Group(name: "2023 형근나무", members: [Member(name: "한솔"),Member(name: "성윤"),Member(name: "부연")]),
            Group(name: "2024 수민나무", members: [Member(name: "한솔"),Member(name: "하은")]),
            Group(name: "2022 지혜나무", members: [Member(name: "문영"),Member(name: "예은"),Member(name: "부연"),Member(name: "부연")]),
            Group(name: "2021 한솔나무", members: [Member(name: "한솔"),Member(name: "수민")]),
            Group(name: "2024 윤재나무", members: [Member(name: "한솔"),Member(name: "부연"),Member(name: "부연")])
        ]
        
        return groups
    }
    
}

