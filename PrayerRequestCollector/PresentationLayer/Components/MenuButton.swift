//
//  MenuButton.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 3/1/24.
//

import SwiftUI

struct MenuButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.action()
            }
        }) {
            Circle()
                .fill(Color.white)
                .frame(width: 40, height: 40)
                .shadow(radius: 5)
                .overlay(
                    Image(systemName: imageName)
                        .foregroundColor(Color.black)
                        .frame(width: 30, height: 30)
                )
//            Image(systemName: imageName)
//                .frame(width: 40, height: 40)
//                .clipShape(Circle())
//                .overlay(Circle().fill(Color.white))
//                .overlay(Circle()
//                    .stroke(Color.white))
//                .shadow(radius: 5)
//                .foregroundColor(Color.black)

        }
    }
}
