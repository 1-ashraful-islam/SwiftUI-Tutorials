//
//  Reminder.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct Reminder: Identifiable, Codable {

    @DocumentID var id: String?
    var title: String
    var isCompleted = false
}

extension Reminder {
    static let collectionName = "reminders"
}

extension Reminder {
    static let samples = [
        Reminder(title: "Build sample app", isCompleted: true),
        Reminder(title: "Create Tutorial"),
        Reminder(title: "???"),
        Reminder(title: "PROFIT!!!"),
    ]
}
