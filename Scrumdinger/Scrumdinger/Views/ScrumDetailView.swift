//
//  ScrumDetailView.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 4/26/24.
//

import SwiftUI

struct ScrumDetailView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var scrum: DailyScrum

    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false

    var body: some View {
        List {
            Section("Meeting Info") {
                NavigationLink {
                    MeetingView()
                } label: {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundStyle(Color.accentColor)
                }

                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("^[\(scrum.lengthInMinutes) minutes](inflect:true)")
                }
                .accessibilityElement(children: .combine)

                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundStyle(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .clipShape(.rect(cornerRadius: 4))
                }
                .accessibilityElement(children: .combine)
            }

            Section("Attendees") {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Edit") {
                    editingScrum = scrum
                    isPresentingEditView = true
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                ScrumDetailEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("cancel") {
                                isPresentingEditView = false
                            }
                        }

                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                scrum = editingScrum
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }

    }
}

#Preview {
    NavigationStack {
        ScrumDetailView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
