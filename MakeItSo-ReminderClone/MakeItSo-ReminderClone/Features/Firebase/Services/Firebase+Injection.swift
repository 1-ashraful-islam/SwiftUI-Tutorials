//
//  Firebase+Injection.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/22/24.
//

import Factory
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

extension Container {

    /// Determines whether to use the Firebase Local Emulator Suite
    /// To use the local emulator, go to the active scheme, and add `-useEmulator YES`
    /// to the _Arguments Passed On Launch_ section.
    public var useEmulator: Factory<Bool> {
        Factory(self) {
            let value = UserDefaults.standard.bool(forKey: "useEmulator")
            print("Using the Firebase Local Emulator: \(value == true ? "YES" : "NO")")
            return value
        }.singleton
    }

    public var firestore: Factory<Firestore> {
        Factory(self) {
            var environment = ""
            if Container.shared.useEmulator() {
                //Configure firestore
                let settings = Firestore.firestore().settings
                settings.host = "localhost:8080"
                settings.cacheSettings = MemoryCacheSettings()
                settings.isSSLEnabled = false
                environment = "to use the local emulator on \(settings.host)"

                Firestore.firestore().settings = settings

                //Configure Auth
                Auth.auth().useEmulator(withHost: "localhost", port: 9099)
            } else {
                environment = "to use the Firebase backend"
            }
            print("Configuring Cloud Firestore \(environment).")

            return Firestore.firestore()
        }.singleton
    }
}
