//
//  GroupViewLiveKey.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2024/01/12.
//

import Foundation
import Dependencies

extension DependencyValues {
    var groupClient: GroupClient {
        get { self[GroupClient.self] }
        set { self[GroupClient.self] = newValue }
    }
}

extension GroupClient: DependencyKey {
    static var liveValue: GroupClient {
        GroupClient(
            getGroups: {
                GroupRepositoryMock.instance.getGroups()
            },
            addGroup: { group in
                GroupRepositoryMock.instance.addGroup(group)
            },
            getAllMembers: {
                GroupRepositoryMock.instance.getAllMember()
            },
            updateGroup: { group in
                GroupRepositoryMock.instance.updateGroup(group)
            }
        )
    }
    
    static var previewValue: GroupClient {
        GroupClient(
            getGroups: {
                GroupRepositoryMock.instance.getGroups()
            },
            addGroup: { group in
                GroupRepositoryMock.instance.addGroup(group)
            },
            getAllMembers: {
                GroupRepositoryMock.instance.getAllMember()
            },
            updateGroup: { group in
                GroupRepositoryMock.instance.updateGroup(group)
            }
        )
    }
}
