//
//  ContentView.swift
//  ChatRoom
//
//  Created by Ashraful Islam on 4/17/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ChatView(userID: UUID())
                .navigationTitle("Chat Room")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem (placement: .topBarTrailing) {
                        Button {
                            Task {
                                print("Sign out")
                            }
                        } label: {
                            Text("Sign Out")
                                .foregroundStyle(.red)
                        }
                        
                    }
                }
        }
        
        
    }
}

#Preview {
    var chatViewModel = ChatViewModel()
    chatViewModel.SampleMessages(UUID())
    
    return ContentView()
        .environment(chatViewModel)
}
