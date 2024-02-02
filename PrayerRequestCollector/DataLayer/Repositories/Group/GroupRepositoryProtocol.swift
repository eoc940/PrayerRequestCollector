//
//  GroupRepositoryProtocol.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation

protocol GroupRepositoryProtocol {
    func getGroups() -> [Group]
    func addGroup(_ group: Group) -> [Group]
    func updateGroup(_ group: Group) -> [Group]
    func getAllMember() -> [Member]
}
