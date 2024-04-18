//
//  ChatRoomApp.swift
//  ChatRoom
//
//  Created by Ashraful Islam on 4/17/24.
//

import SwiftUI
import SwiftData

@main
struct ChatRoomApp: App {
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
