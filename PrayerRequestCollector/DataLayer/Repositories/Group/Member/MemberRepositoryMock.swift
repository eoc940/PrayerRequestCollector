//
//  MemberRepositoryMock.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/26.
//

import Foundation

class MemberRepositoryMock: MemberRepositoryProtocol {
    private var members: [Member] = [
        Member(name: "한솔"),
        Member(name: "예은"),
        Member(name: "하은"),
        Member(name: "성윤"),
        Member(name: "윤재"),
        Member(name: "부연")
    ]
    
    func getAllMember() -> [Member] {
        
        return members
    }
    
    func addMember(_ member: Member) {
        members.append(member)
    }
    
    
}
