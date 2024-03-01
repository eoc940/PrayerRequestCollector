//
//  HomeClient.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import Foundation

struct HomeClient {
    var getRandomPrayers: @Sendable () async throws -> [Prayer]
}
