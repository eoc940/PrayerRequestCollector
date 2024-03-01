//
//  HomeLiveKey.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import Foundation
import Dependencies

extension DependencyValues {
    var homeClient: HomeClient {
        get { self[HomeClient.self]}
        set { self[HomeClient.self] = newValue}
    }
}

extension HomeClient: DependencyKey {
    static var liveValue: HomeClient {
        HomeClient(
            getRandomPrayers: {
                SearchRepositoryMock.instance.getRecommendedPrayers()
            }
        )
    }
    
    static var previewValue: HomeClient {
        HomeClient(
            getRandomPrayers: {
                SearchRepositoryMock.instance.getRecommendedPrayers()
            }
        )
    }
}
