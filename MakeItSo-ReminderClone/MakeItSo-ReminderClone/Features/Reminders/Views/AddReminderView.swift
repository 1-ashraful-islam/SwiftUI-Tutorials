//
//  AddReminderView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import SwiftUI

struct AddReminderView: View {

    enum FocusableField: Hashable {
        case title
    }

    @FocusState
    private var focusedField: FocusableField?

    @State private var reminder = Reminder(title: "")

    @Environment(\.dismiss) private var dismiss

    var onCommit: (_ reminder: Reminder) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.title)
                    .focused($focusedField, equals: .title)
            }
            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: cancelDialog)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: commit)
                        .disabled(reminder.title.isEmpty)
                }
            }
            .onAppear {
                focusedField = .title
            }
        }
    }

    private func commit() {
        onCommit(reminder)
        dismiss()
    }

    private func cancelDialog() {
        dismiss()
    }
}

#Preview {
    AddReminderView { reminder in
        print("Added a new reminder: \(reminder.title)")
    }
}
