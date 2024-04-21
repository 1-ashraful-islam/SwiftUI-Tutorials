//
//  ReminderListViewModel.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import Foundation

@Observable
class ReminderListViewModel {
    var reminders = Reminder.samples

    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }

    func toggleCompleted(_ reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isCompleted.toggle()
        }
    }
}
