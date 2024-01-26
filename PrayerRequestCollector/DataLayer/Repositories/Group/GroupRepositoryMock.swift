//
//  GroupRepositoryMock.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation

class GroupRepositoryMock: GroupRepositoryProtocol {
    static let instance = GroupRepositoryMock()
    
    private init() {}
    
    var groups: [Group] = [
        Group(name: "2023 형근나무", members: [Member(name: "한솔"),Member(name: "성윤"),Member(name: "부연")]),
        Group(name: "2024 수민나무", members: [Member(name: "한솔"),Member(name: "하은")]),
        Group(name: "2022 지혜나무", members: [Member(name: "문영"),Member(name: "예은"),Member(name: "부연"),Member(name: "부연")]),
        Group(name: "2021 한솔나무", members: [Member(name: "한솔"),Member(name: "수민")]),
        Group(name: "2024 윤재나무", members: [Member(name: "한솔"),Member(name: "부연"),Member(name: "부연")])
    ]
    
    func getGroups() -> [Group] {
        
        
        return groups
    }
    
    func addGroup(_ group: Group) -> [Group] {
        groups.insert(group, at: 0)
        return groups
    }
    
}

