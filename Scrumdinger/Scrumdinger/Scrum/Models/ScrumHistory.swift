//
//  ScrumHistory.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 4/27/24.
//

import Foundation

struct ScrumHistory: Identifiable {
    let id = UUID()
    let date: Date
    var attendees: [DailyScrum.Attendee]

    init(date: Date = Date(), attendees: [DailyScrum.Attendee]) {
        self.date = date
        self.attendees = attendees
    }
}
