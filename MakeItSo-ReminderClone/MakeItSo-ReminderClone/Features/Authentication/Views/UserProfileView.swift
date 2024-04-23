//
//  UserProfileView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/22/24.
//

import FirebaseAnalytics
import FirebaseAnalyticsSwift
import SwiftUI

struct UserProfileView: View {
    @StateObject var viewModel = UserProfileViewModel()
    @Environment(\.dismiss) var dismiss
    @State var presentingConfirmationDialog = false

    var body: some View {
        Form {
            Section {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(
                                width: /*@START_MENU_TOKEN@*/ 100 /*@END_MENU_TOKEN@*/,
                                height: 100
                            )
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .clipped()
                            .padding(4)
                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                        Spacer()
                    }
                    Button("edit", action: {})
                }
            }
            .listRowBackground(Color(UIColor.systemGroupedBackground))

            Section("Details") {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.caption)
                    Text(viewModel.displayName)
                }
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.caption)
                    Text(viewModel.email)
                }
                VStack(alignment: .leading) {
                    Text("User ID")
                        .font(.caption)
                    Text(viewModel.user?.uid ?? "Unknown")
                }
                VStack(alignment: .leading) {
                    Text("Provider")
                        .font(.caption)
                    Text(viewModel.provider)
                }
                VStack(alignment: .leading) {
                    Text("Anonymous / Guest user")
                        .font(.caption)
                    Text(viewModel.isGuestUser ? "Yes" : "No")
                }
                VStack(alignment: .leading) {
                    Text("Verified")
                        .font(.caption)
                    Text(viewModel.isVerified ? "Yes" : "No")
                }
            }

            Section {
                Button(role: .cancel, action: signOut) {
                    HStack {
                        Spacer()
                        Text("Sign Out")
                        Spacer()
                    }
                }
            }

            Section {
                Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
                    HStack {
                        Spacer()
                        Text("Delete Account")
                        Spacer()
                    }
                }
            }

        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .analyticsScreen(name: "\(Self.self)")
        .confirmationDialog(
            "Deleting your account is permanent. Do you want to delete your account?",
            isPresented: $presentingConfirmationDialog, titleVisibility: .visible
        ) {
            Button("Delete Account", role: .destructive, action: deleteAccount)
            Button("Cancel", role: .cancel, action: {})
        }
    }

    private func deleteAccount() {
        Task {
            if await viewModel.deleteAccount() == true {
                dismiss()
            }
        }
    }

    private func signOut() {
        viewModel.signOut()
    }
}

#Preview {
    NavigationStack {
        UserProfileView()
    }
}
