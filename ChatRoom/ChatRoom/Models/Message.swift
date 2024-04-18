//
//  Message.swift
//  ChatRoom
//
//  Created by Ashraful Islam on 4/17/24.
//

import Foundation

struct Message: Decodable, Identifiable {
    var id: UUID = .init()
    var createdAt: Date
    var userID: UUID
    var text: String
    var photoURL: String
    
}
