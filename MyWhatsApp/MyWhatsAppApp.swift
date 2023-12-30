//
//  MyWhatsAppApp.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 25/12/23.
//

import FirebaseAuth
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
    @StateObject private var appState = AppState()
    @StateObject private var userModel = UserModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                ZStack {
                    if Auth.auth().currentUser != nil {
                        MainView()
                    } else {
                        LoginView()
                    }
                }.navigationDestination(for: Route.self) { route in
                    switch route {
                        case .main:
                            MainView()
                        case .login:
                            LoginView()
                        case .signUp:
                            SignUpView()
                    }
                }
            }
            .environmentObject(appState)
            .environmentObject(userModel)
        }
    }
}
