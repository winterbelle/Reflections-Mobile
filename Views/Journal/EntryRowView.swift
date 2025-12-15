//
//  EntryRowView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/14/25.
//
import SwiftUI

struct EntryRowView: View {
    let entry: JournalEntry
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.title.isEmpty ? "Untitled Entry" : entry.title)
                        .font(.headline)

                    Text(entry.createdAt.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .font(.subheadline)
                        .foregroundColor(.red.opacity(0.8))
                }
            }

            Text(entry.content)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {

                    if let mood = entry.mood {
                        Text("\(mood.emoji) \(mood.label)")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(10)
                    }

                    ForEach(entry.tags, id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.12))
                            .cornerRadius(10)
                    }

                    Spacer()
                }

                if entry.hasPrompt == true {
                    Text("Prompt Reflection")
                        .font(.caption2)
                        .foregroundColor(Color(hex: "#D96E54"))
                }
            }
        }
        .padding(16)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    EntryRowView(
        entry: JournalEntry(
            title: "A calm moment",
            content: """
Today felt lighter than yesterday. I took a breath before reacting,
and it reminded me that I don’t have to carry everything at once.
""",
            mood: Mood(
                type: .calm,
                emoji: "😌",
                label: "Calm"
            ),
            tags: ["gratitude", "rest"],
            hasPrompt: true
        ),
        onDelete: {
            print("🗑️ Delete tapped")
        }
    )
    .padding()
}
