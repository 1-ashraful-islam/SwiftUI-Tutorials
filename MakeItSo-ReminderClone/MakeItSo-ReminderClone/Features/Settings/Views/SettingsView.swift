//
//  SettingsView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/22/24.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SettingsViewModel()
    @State var isShowSignUpDialogPresented = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink(destination: UserProfileView()) {
                        Label("Account", systemImage: "person.circle")
                    }
                }

                Section {
                    if viewModel.isGuestUser {
                        Button(action: signUp) {
                            HStack {
                                Spacer()
                                Text("Sign up")
                                Spacer()
                            }
                        }
                    } else {
                        Button(action: signOut) {
                            HStack {
                                Spacer()
                                Text("Sign out")
                                Spacer()
                            }
                        }
                    }
                } footer: {
                    HStack {
                        Spacer()
                        Text(viewModel.loggedInAs)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: { dismiss() })
                }
            }
            .sheet(isPresented: $isShowSignUpDialogPresented) {
                AuthenticationView()
            }
        }
    }

    private func signUp() {
        isShowSignUpDialogPresented.toggle()
    }

    private func signOut() {
        viewModel.signOut()
    }
}

#Preview {
    SettingsView()
}
