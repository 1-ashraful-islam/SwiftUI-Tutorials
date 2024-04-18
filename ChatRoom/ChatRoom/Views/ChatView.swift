//
//  ChatView.swift
//  ChatRoom
//
//  Created by Ashraful Islam on 4/17/24.
//

import SwiftUI

@Observable
class ChatViewModel {
    var messages: [Message] = []
    
    
    func sendMessage(text: String) {
        messages.append(.init(createdAt: Date(), userID: UUID(), text: text, photoURL: ""))
    }
    
    func SampleMessages(_ userID: UUID) {
        messages.append(.init(createdAt: Date(), userID: userID, text: "A message from the user", photoURL: ""))
        messages.append(.init(createdAt: Date(), userID: UUID(), text: "A message from another user", photoURL: ""))
        
    }
}

struct ChatView: View {
    @Environment(ChatViewModel.self) private var chatViewModel
    @State var text = ""
    
    var userID: UUID
    
    private var trimmedText: String {
        text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    ForEach(chatViewModel.messages) {message in
                        MessageView(message: message, isFromCurrentUser: message.userID == userID)
                    }
                }
            }
            
            Divider()
            
            HStack {
                TextField("Enter Text", text: $text, axis: .vertical)
                    .lineLimit(7)
                    .padding()
                    .background(Color(uiColor: .systemGray6))

                Button {
                    sendMessage()
                } label: {
                    Label("Send", systemImage: "paperplane")
                }
                .disabled(trimmedText.isEmpty)
                
//                .labelStyle(.iconOnly)
            }
            .padding()
        }
    }
    private func sendMessage() {
        Task {
            chatViewModel.sendMessage(text: trimmedText)
            text = ""
        }
    }
}

#Preview {
    @State var sampleChatViewModel = ChatViewModel()
    var userID: UUID = UUID()
    sampleChatViewModel.SampleMessages(userID)
    
    return ChatView(userID: userID)
        .environment(sampleChatViewModel)
}
