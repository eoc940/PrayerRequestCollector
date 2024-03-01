//
//  SearchRepositoryMock.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import Foundation

class SearchRepositoryMock: SearchRepositoryProtocol {
    static let instance = SearchRepositoryMock()
    
    private init() {
        mockData.forEach { prayer in
            self.savedPrayers[prayer.id] = prayer
        }
    }
    
    private var savedPrayers: [String: Prayer] = [:]
    
    private var mockData: [Prayer] = [
        Prayer(memberName: "한솔", content: "배우자 기도"),
        Prayer(memberName: "성윤", content: "좋은 믿음의 동역자들을 주시길"),
        Prayer(memberName: "한솔", content: "무기력하지 않게"),
        Prayer(memberName: "예은", content: "항상 감사할 수 있길"),
        Prayer(memberName: "수민", content: "건강을 위한 기도"),
        Prayer(memberName: "성윤", content: "항상 감사하는 마음 가지길"),
        Prayer(memberName: "예은", content: "변화산 잘 완주하도록"),
    ]
    
    func getRecommendedPrayers() -> [Prayer] {
        // 추후 로직 수정 예정
        let randomPrayers = self.savedPrayers.values.shuffled()
        
        return Array(randomPrayers[0..<3])
    }
}
