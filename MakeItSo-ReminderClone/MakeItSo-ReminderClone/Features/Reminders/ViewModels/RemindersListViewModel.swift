//
//  ReminderListViewModel.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import Combine
import Foundation

class RemindersListViewModel: ObservableObject {
    @Published var reminders = [Reminder]()
    @Published var errorMessage: String?

    private var remindersRepository = RemindersRepository()

    init() {
        remindersRepository.$reminders.assign(to: &$reminders)
    }

    func addReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.addReminder(reminder)
            errorMessage = nil
        } catch {
            print("failed with error: \(error)")
            errorMessage = error.localizedDescription
        }
    }

    func updateReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.updateReminder(reminder)
        } catch {
            print(
                "failed to update reminder: \(reminder.title) with error: \(error.localizedDescription)"
            )
            errorMessage = error.localizedDescription
        }
    }

    func deleteReminder(_ reminder: Reminder) {
        remindersRepository.removeReminder(reminder)
    }

    func setCompleted(_ reminder: Reminder, isCompleted: Bool) {
        var editedReminder = reminder
        editedReminder.isCompleted = isCompleted
        updateReminder(editedReminder)
    }
}
