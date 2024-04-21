//
//  MakeItSo_ReminderCloneApp.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()

        // MARK: Firebase Emulator settings
        let useEmulator = UserDefaults.standard.bool(forKey: "useEmulator")
        if useEmulator {

            print("Using Firebase Emulator")
            //Configure firestore
            let settings = Firestore.firestore().settings
            settings.host = "localhost:8080"
            settings.cacheSettings = MemoryCacheSettings()
            settings.isSSLEnabled = false
            Firestore.firestore().settings = settings

            //Configure Auth
            Auth.auth().useEmulator(withHost: "localhost", port: 9099)
        }

        return true
    }
}

@main
struct MakeItSo_ReminderCloneApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            RemindersList()
                .environment(ReminderListViewModel())
        }
    }
}
