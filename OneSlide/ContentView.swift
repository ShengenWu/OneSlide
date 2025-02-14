//
//  ContentView.swift
//  OneSlide
//
//  Created by Shane Wu on 2025/2/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            UnorganizedView()
                .tabItem {
                    Image(systemName: "photo")
                    Text("未整理")
                }
            
            AlbumView()
                .tabItem {
                    Image(systemName: "rectangle.stack")
                    Text("相簿")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("设置")
                }
        }
    }
}

#Preview {
    ContentView()
}
