//
//  Date+Extension.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/25/24.
//

import Foundation

extension Date {
    /// Checks if the date is within a specified number of minutes in the past
    func isWithinPast(minutes: Int) -> Bool {
        let now = Date()
        let pastDate = now.addingTimeInterval(TimeInterval(-minutes * 60))
        let range = pastDate ... now
        return range.contains(self)
    }
}
