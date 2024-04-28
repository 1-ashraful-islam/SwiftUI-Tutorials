//
//  NewScrumSheetView.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 4/27/24.
//

import SwiftUI

struct NewScrumSheetView: View {

    @Binding var scrums: [DailyScrum]
    @Environment(\.dismiss) var dismiss

    @State private var newScrum = DailyScrum.emptyScrum

    var body: some View {
        NavigationStack {
            ScrumDetailEditView(scrum: $newScrum)
                .navigationTitle(newScrum.title)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum)
                            dismiss()
                        }
                        .disabled(newScrum.title.isEmpty || newScrum.attendees.isEmpty)
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    NewScrumSheetView(scrums: .constant(DailyScrum.sampleData))
}
