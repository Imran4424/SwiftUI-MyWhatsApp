//
//  MainView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 30/12/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            GroupListContainerView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill")
                }
            
            SettingsView()
                .tabItem { 
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainView()
}
