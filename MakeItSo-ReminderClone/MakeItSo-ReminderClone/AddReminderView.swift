//
//  AddReminderView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import SwiftUI

struct AddReminderView: View {
    @State private var reminder = Reminder(title: "")

    @Environment(\.dismiss) private var dismiss

    var onCommit: (_ reminder: Reminder) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.title)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: commit)
                }
            }
        }
    }

    private func commit() {
        onCommit(reminder)
        dismiss()
    }
}

#Preview {
    AddReminderView { reminder in
        print("Added a new reminder: \(reminder.title)")
    }
}
