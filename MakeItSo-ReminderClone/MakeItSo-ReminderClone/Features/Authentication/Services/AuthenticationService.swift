//
//  AuthenticationService.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/23/24.
//

import AuthenticationServices
import Factory
import FirebaseAuth
import Foundation
import GoogleSignIn
import GoogleSignInSwift

enum AuthenticationError: Error {
    case tokenError(message: String)
}

public class AuthenticationService {
    // MARK: - Dependencies
    @Injected(\.auth) private var auth
    @Injected(\.firebaseOptions) private var firebaseOptions

    @Published var user: User?
    @Published var errorMessage = ""

    private var currentNonce: String?

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

// MARK: Sign in with email and password
extension AuthenticationService {

    @MainActor
    func signInWithEmailPassword(_ email: String, password: String) async -> Bool {
        do {
            try await auth.signIn(withEmail: email, password: password)
            return true
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            return false
        }
    }

    @MainActor
    func signUpWithEmailPassword(_ email: String, password: String) async -> Bool {
        do {
            try await auth.createUser(withEmail: email, password: password)
            return true
        } catch {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            return false
        }
    }

}

// MARK: - Sign in with Google
extension AuthenticationService {
    @MainActor
    func signInWithGoogle() async -> Bool {
        guard let clientID = firebaseOptions.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard
            let windowScene = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .first as? UIWindowScene,
            let window = windowScene.windows
                .filter({ $0.isKeyWindow })
                .first,
            let rootViewController = window.rootViewController
        else {
            print("There is no root view controller")
            return false
        }
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(
                withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                throw AuthenticationError.tokenError(message: "ID token missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken.tokenString,
                accessToken: accessToken.tokenString)

            try await auth.signIn(with: credential)

            return true
        } catch {
            errorMessage = error.localizedDescription
            print(errorMessage)
            return false
        }

    }
}

// MARK: - Sign in with Apple

extension AuthenticationService {
    @MainActor
    func handleSignInWithAppleCompletion(
        withAccountLinking: Bool = false, _ result: Result<ASAuthorization, Error>
    ) async -> Bool {
        if case .failure(let failure) = result {
            errorMessage = failure.localizedDescription
            return false
        } else if case .success(let authorization) = result {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
            {
                guard let nonce = currentNonce else {
                    fatalError(
                        "Invalid state: a login callback was received, but no login request was sent."
                    )
                }

                guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Unable to fetch identity token.")
                    return false
                }

                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print(
                        "Unable to serialize token string from data: \(appleIDToken.debugDescription)"
                    )
                    return false
                }

                let credential = OAuthProvider.appleCredential(
                    withIDToken: idTokenString,
                    rawNonce: nonce,
                    fullName: appleIDCredential.fullName)

                do {
                    if withAccountLinking {
                        let authResult = try await user?.link(with: credential)
                        self.user = authResult?.user

                    } else {
                        try await auth.signIn(with: credential)
                    }
                    return true
                } catch {
                    print("Error authenticating: \(error.localizedDescription)")
                    return false
                }
            }
        }

        return false
    }

    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]

        do {
            let nonce = try CryptoUtils.randomNonceString()
            currentNonce = nonce
            request.nonce = CryptoUtils.sha256(nonce)
        } catch {
            print("Error when creating a nonce: \(error.localizedDescription)")
        }
    }
}
