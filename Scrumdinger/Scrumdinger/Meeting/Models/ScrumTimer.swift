//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 4/26/24.
//

import Foundation

@MainActor
final class ScrumTimer: ObservableObject {
    /// A struct to keep track of meeting attendees during a meeting
    struct Speaker: Identifiable {
        var id = UUID()
        let name: String
        var isCompleted = false
    }

    @Published var activeSpeaker = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0

    private(set) var speakers: [Speaker] = []
    private(set) var lengthInMinutes: Int = 0

    /// A closure that is executed when a new attendee begins speaking
    var speakerChangedAction: (() -> Void)?

    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int { lengthInSeconds / speakers.count }
    private var speakerIndex = 0
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerText: String {
        "Speaker \(speakerIndex + 1): \(speakers[speakerIndex].name)"
    }
    private var startDate: Date?

    init(lengthInMinutes: Int = 0, attendees: [DailyScrum.Attendee] = []) {
        reset(lengthInMinutes: lengthInMinutes, attendees: attendees)
    }

    func startScrum() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) {
            [weak self] timer in

            self?.update()
        }
        timer?.tolerance = 0.1
        changeToSpeaker(at: 0)
    }

    func stopScrum() {
        timer?.invalidate()
        timerStopped = true
    }

    nonisolated func skipSpeaker() {

        Task { @MainActor in
            changeToSpeaker(at: speakerIndex + 1)
        }
    }

    private func changeToSpeaker(at index: Int) {
        if index > 0 {
            secondsElapsed = index * secondsPerSpeaker
            secondsRemaining = lengthInSeconds - secondsElapsed
            speakers[speakerIndex].isCompleted = true
            guard index < speakers.count else {
                stopScrum()
                return
            }
        }
        secondsElapsedForSpeaker = 0
        speakerIndex = index
        activeSpeaker = speakerText

        startDate = Date()

    }

    nonisolated private func update() {
        Task { @MainActor in

            guard let startDate,
                !timerStopped
            else { return }

            secondsElapsedForSpeaker = Int(Date().timeIntervalSince(startDate))
            secondsElapsed = speakerIndex * secondsPerSpeaker + secondsElapsedForSpeaker

            secondsRemaining = max(lengthInSeconds - secondsElapsed, 0)
            if secondsElapsedForSpeaker >= secondsPerSpeaker {
                changeToSpeaker(at: speakerIndex + 1)
                speakerChangedAction?()
            }
        }

    }

    func reset(lengthInMinutes: Int, attendees: [DailyScrum.Attendee]) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
}

extension [DailyScrum.Attendee] {
    var speakers: [ScrumTimer.Speaker] {
        if isEmpty {
            return [ScrumTimer.Speaker(name: "Speaker 1")]
        } else {
            return map { ScrumTimer.Speaker(name: $0.name) }
        }
    }
}
