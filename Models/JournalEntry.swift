//
//  Entry.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//

import Foundation

struct JournalEntry: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var mood: Mood? //optional incase user doesnt choose one
    var tags: [String]
    var createdAt: Date
    var updatedAt: Date? //only if user goes back an updates their entry
    var isFavorite: Bool
    var hasPrompt: Bool? //true or false depending on whether this entry came from a prompt
    
    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        mood: Mood? = nil,
        tags: [String] = [],
        createdAt: Date = Date(),
        updatedAt: Date? = nil,
        isFavorite: Bool = false,
        hasPrompt: Bool? = false
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.mood = mood
        self.tags = tags
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isFavorite = isFavorite
        self.hasPrompt = hasPrompt
    }
}

