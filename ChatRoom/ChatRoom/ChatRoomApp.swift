//
//  ChatRoomApp.swift
//  ChatRoom
//
//  Created by Ashraful Islam on 4/17/24.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ChatRoomApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @State private var userSignedIn = false
    
    var body: some Scene {
        WindowGroup {
            if userSignedIn {
                ContentView()
                    .environment(ChatViewModel())
            } else {
                SignInView()
            }
        }
    }
}
