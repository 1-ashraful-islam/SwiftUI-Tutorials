//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 5/5/24.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    private var currentSpeaker: String? {
        speakers.first(where: { !$0.isCompleted })?.name
    }

    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    if let currentSpeaker = currentSpeaker {
                        Text(currentSpeaker)
                            .font(.title)
                        Text("is speaking")
                    } else {
                        Text("Meeting is over")
                            .font(.title)
                    }
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted,
                        let index = speakers.firstIndex(where: { $0.id == speaker.id })
                    {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

#Preview {
    var speakers: [ScrumTimer.Speaker] {
        [
            ScrumTimer.Speaker(name: "Bill", isCompleted: true),
            ScrumTimer.Speaker(name: "Cathy", isCompleted: true),
        ]
    }

    return MeetingTimerView(speakers: speakers, theme: .yellow)
}
