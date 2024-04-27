//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 4/25/24.
//

import AVFoundation
import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()

    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)

            VStack {
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)

                Circle()
                    .strokeBorder(lineWidth: 24)

                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)

            }
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            /// plays a ding if the speaker goes over time and moves to next speaker
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
