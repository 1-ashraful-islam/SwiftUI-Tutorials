//
//  ReminderListRowView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import SwiftUI

struct ReminderListRowView: View {
    @Binding
    var reminder: Reminder

    var body: some View {
        HStack {
            Image(systemName: reminder.isCompleted ? "largecircle.fill.circle" : "circle")
                .imageScale(.large)
                .foregroundStyle(Color.accentColor)
                .onTapGesture {
                    reminder.isCompleted.toggle()
                }

            Text(reminder.title)
        }
    }
}

#Preview {
    struct Container: View {
        @State var reminder = Reminder.samples

        var body: some View {
            NavigationStack {
                List {
                    ReminderListRowView(reminder: $reminder[0])

                    ReminderListRowView(reminder: $reminder[1])
                }
                .listStyle(.plain)
                .navigationTitle("Reminders")
            }
        }
    }

    return Container()
}
