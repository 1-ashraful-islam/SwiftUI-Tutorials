//
//  ContentView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @State private var reminders = Reminder.samples

    @State private var isAddReminderDialogPresented = false

    var body: some View {
        List($reminders) { $reminder in
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
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: presentAddReminderView) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                }
                Spacer()

            }
        }
        .sheet(isPresented: $isAddReminderDialogPresented) {
            AddReminderView { reminder in
                reminders.append(reminder)
            }
        }
    }

    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }

}

#Preview {
    NavigationStack {
        ContentView()
            .navigationTitle("Reminders")
    }
}
