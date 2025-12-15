//
//  Mood.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//

import Foundation

enum MoodType: String, CaseIterable, Codable {
    case calm, sad, overwhelmed, grateful, happy, frustrated, angry, tired, joyful, okay, overstimulated
}

struct Mood: Identifiable, Codable {
    let id: UUID
    let type: MoodType
    let emoji: String
    let label: String

    init(
        id: UUID = UUID(),
        type: MoodType,
        emoji: String,
        label: String
    ) {
        self.id = id
        self.type = type
        self.emoji = emoji
        self.label = label
    }
}



