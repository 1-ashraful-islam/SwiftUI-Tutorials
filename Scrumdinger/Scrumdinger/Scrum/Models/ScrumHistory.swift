//
//  ScrumHistory.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 4/27/24.
//

import Foundation

struct ScrumHistory: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]

    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee]) {
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}
