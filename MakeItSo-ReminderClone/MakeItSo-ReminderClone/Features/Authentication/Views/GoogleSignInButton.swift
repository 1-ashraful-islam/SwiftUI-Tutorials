//
//  GoogleSignInButton.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/23/24.
//

import SwiftUI

enum GoogleSignInButtonLabel: String {
    case signUp = "Sign in with Google"
    case `continue` = "Continue with Google"
    case signIn = "Sign up with Google"
}

struct GoogleSignInButton: View {
    @Environment(\.colorScheme) private var colorScheme

    var label: GoogleSignInButtonLabel = .continue
    var action: () -> Void

    init(_ label: GoogleSignInButtonLabel, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 2) {
                Image("Google")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, alignment: .center)
                Text(label.rawValue)
                    .bold()
                    .padding(.vertical, 8)
            }
            .frame(maxWidth: .infinity)
        }
        .foregroundStyle(Color(colorScheme == .dark ? .black : .white))
        .background(colorScheme == .dark ? .white : .black)
        .cornerRadius(8)
        .buttonStyle(.bordered)
    }
}

#Preview("Light") {
    GoogleSignInButton(.signUp) {
        print("user clicked Google sign in")
    }
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    GoogleSignInButton(.signUp) {
        print("user clicked Google sign in")
    }
    .preferredColorScheme(.dark)
}
