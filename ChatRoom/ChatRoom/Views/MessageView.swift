//
//  MessageView.swift
//  ChatRoom
//
//  Created by Ashraful Islam on 4/17/24.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    var isFromCurrentUser: Bool = false

    var userAvatar: some View {
        Image(systemName: "person")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 32)
            .padding(.vertical, 16)
    }

    func userMessage(_ text: String, _ color: Color) -> some View {
        HStack {
            Text(text)
        }
        .frame(maxWidth: 250, alignment: .leading)
        .padding()
        .background(color)
        .clipShape(.rect(cornerRadius: 20))
    }

    var body: some View {
        if isFromCurrentUser {
            HStack(alignment: .top) {
                Spacer()
                userMessage(message.text, .blue.opacity(0.6))
                userAvatar
                    .padding(.leading, 4)
            }
            .padding(.horizontal, 8)
        } else {
            HStack(alignment: .top) {
                userAvatar
                    .padding(.trailing, 4)
                userMessage(message.text, .gray.opacity(0.3))
                Spacer()
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    Group {
        MessageView(
            message: .init(
                createdAt: .init(), userID: .init(),
                text: "A message sample A message sample A message sample\n\n\n A sample",
                photoURL: ""))
        MessageView(
            message: .init(
                createdAt: .init(), userID: .init(),
                text: "A message sample A message sample A message sample\n\n\n A sample",
                photoURL: ""), isFromCurrentUser: true)
    }
}
