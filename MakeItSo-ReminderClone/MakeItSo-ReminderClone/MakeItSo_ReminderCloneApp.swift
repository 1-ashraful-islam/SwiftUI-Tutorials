//
//  MakeItSo_ReminderCloneApp.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import Factory
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    @LazyInjected(\.authenticationService) private var authenticationService

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        FirebaseApp.configure()
        authenticationService.signInAnonymously()

        return true
    }
}

@main
struct MakeItSo_ReminderCloneApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RemindersListView()
                    .environmentObject(RemindersListViewModel())
                    .navigationTitle("Reminders")
            }
        }
    }
}
