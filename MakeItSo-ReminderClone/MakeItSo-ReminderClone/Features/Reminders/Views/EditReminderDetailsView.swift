//
//  AddReminderView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import SwiftUI

struct EditReminderDetailsView: View {

    enum FocusableField: Hashable {
        case title
    }

    @FocusState
    private var focusedField: FocusableField?

    enum Mode {
        case add
        case edit
    }

    var mode: Mode = .add

    @State var reminder = Reminder(title: "")

    @Environment(\.dismiss) private var dismiss

    let onCommit: (_ reminder: Reminder) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.title)
                    .focused($focusedField, equals: .title)
                    .onSubmit(commit)
            }
            .navigationTitle(mode == .add ? "New Reminder" : "Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: cancelDialog)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(mode == .add ? "Add" : "Done", action: commit)
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

#Preview("Edit Reminder") {
    struct Container: View {
        @State var reminder = Reminder.samples[0]

        var body: some View {
            EditReminderDetailsView(mode: .edit, reminder: reminder) { reminder in
                print("You edited reminder: \(reminder.title)")
            }
        }
    }

    return Container()
}

#Preview("Add Reminder") {

    EditReminderDetailsView { reminder in
        print("Added a new reminder: \(reminder.title)")
    }
}
