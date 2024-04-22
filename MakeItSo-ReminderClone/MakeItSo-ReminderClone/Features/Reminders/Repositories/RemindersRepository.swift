//
//  RemindersRepository.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/21/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

@Observable
class RemindersRepository {
    var reminders = [Reminder]()

    func addReminder(_ reminder: Reminder) throws {
        print(reminder)
        try Firestore
            .firestore()
            .collection("reminders")
            .addDocument(from: reminder)
    }
}
