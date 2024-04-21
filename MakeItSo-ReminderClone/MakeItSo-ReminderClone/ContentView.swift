//
//  ContentView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/20/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @State private var reminders = Reminder.samples

    var body: some View {
        List(reminders) { reminder in
            HStack {
                Image(systemName: reminder.isCompleted ? "largecircle.fill.circle" : "circle")
                    .imageScale(.large)
                    .foregroundStyle(Color.accentColor)

                Text(reminder.title)
            }
        }
    }
}

#Preview {
    ContentView()
}
