//
//  ContentView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import SwiftData
import SwiftUI

struct ReminderList: View {

    @Environment(ReminderListViewModel.self) private var viewModel
    @State private var isAddReminderDialogPresented = false

    var body: some View {
        @Bindable var viewModel = viewModel

        List($viewModel.reminders) { $reminder in
            ReminderListRowView(reminder: $reminder)
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
    }

    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }

}

#Preview {
    NavigationStack {
        ReminderList()
            .environment(ReminderListViewModel())
            .navigationTitle("Reminders")
    }
}
