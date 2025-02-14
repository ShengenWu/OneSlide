//
//  ContentView.swift
//  OneSlide
//
//  Created by Shane Wu on 2025/2/14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var photoLoader = PhotoLoader()
    
    var body: some View {
        Group {
            if photoLoader.hasPermission {
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
            } else {
                VStack {
                    Text("需要访问相册权限")
                    Button("前往设置") {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
