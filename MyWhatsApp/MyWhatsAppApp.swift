//
//  MyWhatsAppApp.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 25/12/23.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct MyWhatsAppApp: App {
    // register app delegate for firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
