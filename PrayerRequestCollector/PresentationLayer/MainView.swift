//
//  MainView.swift
//  PrayerRequestCollector
//
//  Created by Khg Dev on 2023/12/01.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    }
    
    var body: some View {
        tabbar
    }
}

extension MainView {
    var tabbar: some View {
        
        TabView {
            MemberView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("모임")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.gray, for: .tabBar)
            WriteView()
                .tabItem {
                    Image(systemName: "pencil.line")
                    Text("작성")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.gray, for: .tabBar)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.gray, for: .tabBar)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
