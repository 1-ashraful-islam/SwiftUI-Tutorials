//
//  AuthenticationService.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/23/24.
//

import Factory
import FirebaseAuth
import Foundation

public class AuthenticationService {
    @Injected(\.auth) private var auth
    @Published var user: User?

    private var authStateHandler: AuthStateDidChangeListenerHandle?

    init() {
        registerAuthStateHandler()
        signInAnonymously()
    }

    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = auth.addStateDidChangeListener { auth, user in
                self.user = user
            }
        }
    }

    func signOut() {
        do {
            try auth.signOut()
            signInAnonymously()
        } catch {
            print("Error while trying to sign out: \(error.localizedDescription)")
        }
    }

    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            signOut()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

}

// MARK: - Sign in anonymously

extension AuthenticationService {
    func signInAnonymously() {
        if auth.currentUser == nil {
            print("Nobody is signed in. Trying to sign in anonymously")
            auth.signInAnonymously()
        } else {
            if let user = auth.currentUser {
                print("Someone is signed in with \(user.providerID) and user ID \(user.uid)")
            }
        }
    }
}
