//
//  GroupRepositoryMock.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation

class GroupRepositoryMock: GroupRepositoryProtocol {
    static let instance = GroupRepositoryMock()
    
    private init() {
        mockData.forEach { group in
            self.savedGroups[group.id] = group
        }
    }
    
    private var mockData: [Group] = [
        Group(name: "2023 형근나무", members: [Member(name: "한솔"),Member(name: "성윤"),Member(name: "부연")]),
        Group(name: "2024 수민나무", members: [Member(name: "한솔"),Member(name: "하은")]),
        Group(name: "2022 지혜나무", members: [Member(name: "문영"),Member(name: "예은"),Member(name: "부연"),Member(name: "하은")]),
        Group(name: "2021 한솔나무", members: [Member(name: "한솔"),Member(name: "수민")]),
        Group(name: "2024 윤재나무", members: [Member(name: "한솔"),Member(name: "수민"),Member(name: "부연")])
    ]
    
    private var savedGroups: [String: Group] = [:]
    
    func getGroups() -> [Group] {
        
        return sortByDate(groups: self.savedGroups)
    }
    
    func addGroup(_ group: Group) -> [Group] {
        self.savedGroups[group.id] = group
        return sortByDate(groups: self.savedGroups)
    }
    
    func updateGroup(_ group: Group) -> [Group] {
        self.savedGroups[group.id] = group
        return sortByDate(groups: self.savedGroups)
    }
    
    func getAllMember() -> [Member] {
        let allMemberInAllGroup = self.savedGroups.values
            .map { group in
                group.members
            }
            .reduce([]) { partialResult, members in
                partialResult + members
            }
            
        return Array(Set(allMemberInAllGroup))
    }
    
}

private extension GroupRepositoryMock {
    func sortByDate(groups: [String: Group]) -> [Group] {
        return groups.values.sorted { lhs, rhs in
            lhs.createdDate > rhs.createdDate
        }
    }
}

