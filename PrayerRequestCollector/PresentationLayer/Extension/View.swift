//
//  View.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2/28/24.
//

import Foundation
import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? .zero : 1)
    }
}
