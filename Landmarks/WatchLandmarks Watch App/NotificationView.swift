//
//  NotificationView.swift
//  WatchLandmarks Watch App
//
//  Created by Ashraful Islam on 2/13/24.
//

import SwiftUI

struct NotificationView: View {
    var title: String?
    var message: String?
    var landmark: Landmark?

    var body: some View {
        VStack {
            if let landmark {
                CircleImage(image: landmark.image.resizable())
                    .scaledToFit()
            }

            Text(title ?? "Unknown Landmark")
                .font(.headline)

            Divider()

            Text(message ?? "You are within 5 miles of one of your favorite landmarks")
                .font(.caption)
        }
    }
}

#Preview("No data") {
    NotificationView()
}

#Preview("Turtle Rock") {
    NotificationView(
        title: "Turtle Rock",
        message: "You are within 2 miles of Turtle Rock.",
        landmark: ModelData().landmarks[0]
    )
}
