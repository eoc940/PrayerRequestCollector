//
//  MemberRepositoryProtocol.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/26.
//

import Foundation

protocol MemberRepositoryProtocol {
    func getAllMember() -> [Member]
    func addMember(_ member: Member)
}
