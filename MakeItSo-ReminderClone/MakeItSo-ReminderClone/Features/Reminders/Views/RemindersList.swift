//
//  ContentView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import SwiftData
import SwiftUI

struct RemindersList: View {

    @EnvironmentObject private var viewModel: RemindersListViewModel
    @State private var isAddReminderDialogPresented = false

    var body: some View {

        List($viewModel.reminders) { $reminder in
            RemindersListRowView(reminder: $reminder)
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
                viewModel.addReminder(reminder)
            }
        }
        .tint(.red)
    }

    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }

}

#Preview {
    NavigationStack {
        RemindersList()
            .environmentObject(RemindersListViewModel())
            .navigationTitle("Reminders")
    }
}
