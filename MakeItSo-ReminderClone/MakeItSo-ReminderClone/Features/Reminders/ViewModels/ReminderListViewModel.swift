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
    var errorMessage: String?

    private var remindersRepository = RemindersRepository()

    func addReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.addReminder(reminder)
            errorMessage = nil
        } catch {
            print("failed with error: \(error)")
            errorMessage = error.localizedDescription
        }
    }

    func toggleCompleted(_ reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isCompleted.toggle()
        }
    }
}
