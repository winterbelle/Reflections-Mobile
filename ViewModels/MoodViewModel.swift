//
//  MoodViewModel.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//

import Foundation
import SwiftUI

@MainActor
final class MoodViewModel: ObservableObject {
    @Published var moods: [Mood] = [
        Mood(type: .happy, emoji: "😊", label: "Happy"),
        Mood(type: .sad, emoji: "😔", label: "Sad"),
        Mood(type: .frustrated, emoji: "😖", label: "Frustrated"),
        Mood(type: .angry, emoji: "😤", label: "Angry"),
        Mood(type: .tired, emoji: "🫩", label: "Tired"),
        Mood(type: .calm, emoji: "😌", label: "Calm"),
        Mood(type: .overwhelmed, emoji: "😓", label: "Overwhelmed"),
        Mood(type: .joyful, emoji: "🥰", label: "Joyful"),
        Mood(type: .okay, emoji: "🙂", label: "Okay"),
        Mood(type: .overstimulated, emoji: "😵‍💫", label: "Overstimulated"),
        Mood(type: .grateful, emoji: "🙏", label: "Grateful")
    ]
    
    @Published var selectedMood: Mood? = nil
    
    
}

