//
//  CardView.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 4/25/24.
//

import SwiftUI

struct ScrumCardView: View {
    let scrum: DailyScrum

    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)

            Spacer()
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("^[\(scrum.attendees.count) attendees](inflect: true)")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .accessibilityLabel("^[\(scrum.lengthInMinutes) minute meeting](inflect: true)")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
    }
}

#Preview {
    Group {
        var scrum = DailyScrum.sampleData[0]
        ScrumCardView(scrum: scrum)
            .background(scrum.theme.mainColor)
            .frame(height: 60)
    }

}
