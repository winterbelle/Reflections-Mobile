//
//  MoodSelectorView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//

import SwiftUI

struct MoodSelectorView: View {
    @Binding var selectedMood: Mood?

    // Use the same moods list you already had in MoodViewModel
    private let moods: [Mood] = [
        Mood(type: .happy, emoji: "😊", label: "Happy"),
        Mood(type: .sad, emoji: "😔", label: "Sad"),
        Mood(type: .frustrated, emoji: "😖", label: "Frustrated"),
        Mood(type: .angry, emoji: "😤", label: "Angry"),
        Mood(type: .tired, emoji: "😴", label: "Tired"),
        Mood(type: .calm, emoji: "😌", label: "Calm"),
        Mood(type: .overwhelmed, emoji: "😓", label: "Overwhelmed"),
        Mood(type: .joyful, emoji: "🥰", label: "Joyful"),
        Mood(type: .okay, emoji: "🙂", label: "Okay"),
        Mood(type: .overstimulated, emoji: "😵‍💫", label: "Overstimulated"),
        Mood(type: .grateful, emoji: "🙏", label: "Grateful")
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(moods) { mood in
                    VStack(spacing: 6) {
                        Text(mood.emoji)
                            .font(.largeTitle)

                        Text(mood.label)
                            .font(.caption)
                            .fontWeight(.black)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                    }
                    .frame(width: 80, height: 80)
                    .contentShape(Rectangle())
                    .padding()
                    .background(
                        mood.type == selectedMood?.type
                        ? Color(hex: "#D96E54")
                        : Color.white
                    )
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectedMood = mood
                    }
                }
            }
        }
    }
}
