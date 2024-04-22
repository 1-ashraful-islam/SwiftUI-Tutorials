//
//  RemindersListRowView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import SwiftUI

struct RemindersListRowView: View {
    @Binding
    var reminder: Reminder

    var body: some View {
        HStack {
            Toggle(isOn: $reminder.isCompleted) { /* empty on purpose */  }
                .toggleStyle(.reminder)

            Text(reminder.title)

            Spacer()
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    struct Container: View {
        @State var reminder = Reminder.samples

        var body: some View {
            NavigationStack {
                List {
                    RemindersListRowView(reminder: $reminder[0])

                    RemindersListRowView(reminder: $reminder[1])
                }
                .listStyle(.plain)
                .navigationTitle("Reminders")
            }
        }
    }

    return Container()
}
