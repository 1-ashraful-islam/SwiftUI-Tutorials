//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 4/25/24.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData

    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
