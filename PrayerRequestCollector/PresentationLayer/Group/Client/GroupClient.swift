//
//  GroupViewClient.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation

struct GroupClient {
    var getGroups: @Sendable () async throws -> [Group]
    var addGroup: @Sendable (_ group: Group) async throws -> [Group]
    var getAllMembers: @Sendable () async throws -> [Member]
    var updateGroup: @Sendable (_ group: Group) async throws -> [Group]
}
