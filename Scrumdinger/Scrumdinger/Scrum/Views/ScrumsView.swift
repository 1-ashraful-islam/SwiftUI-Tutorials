//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 4/26/24.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: () -> Void

    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink {
                    ScrumDetailView(scrum: $scrum)
                } label: {
                    ScrumCardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        isPresentingNewScrumView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Scrum")
                }
            }
            .sheet(isPresented: $isPresentingNewScrumView) {
                NewScrumSheetView(scrums: $scrums)
            }
            .onChange(of: scenePhase) {
                if scenePhase == .inactive {
                    saveAction()
                }
            }
        }
    }
}

#Preview {
    ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
}
