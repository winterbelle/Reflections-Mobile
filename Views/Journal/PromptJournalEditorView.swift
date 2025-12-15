//
//  PromptJournalEditorView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/13/25.
//

import SwiftUI

struct PromptJournalEditorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: JournalEntryViewModel

    let prompt: String
    let selectedMood: Mood

    @State private var title: String = ""
    @State private var content: String = ""
    @State private var tags: [String] = []
    @State private var newTag: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Prompt (read-only)
                Text(prompt)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .italic()
                    .padding(3)
                    .background(Color(.white))
                
                TextField("Entry Title", text: $title)
                    .font(.title2)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    
                Text("Tags")
                    .font(.headline)

                HStack {
                    TextField("Add Tag", text: $newTag)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button("Add") {
                        if !newTag.isEmpty {
                            tags.append(newTag)
                            newTag = ""
                        }
                    }
                }

                tagList

                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemBackground))

                    if content.isEmpty {
                        Text("Respond to the prompt…")
                            .foregroundColor(.gray)
                            .padding(.top, 12)
                            .padding(.leading, 8)
                            .allowsHitTesting(false)
                    }

                    TextEditor(text: $content)
                        .padding(8)
                        .frame(minHeight: 200)
                        .scrollContentBackground(.hidden)
                }

                Button(action: saveEntry) {
                    Text("Save Entry")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#D96E54"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("New Entry")
        .navigationBarTitleDisplayMode(.large)
    }

    private var tagList: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: 5),
            count: 4
        )

        return LazyVGrid(columns: columns, spacing: 5) {
            ForEach(tags, id: \.self) { tag in
                Text("#\(tag)")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
        }
    }

    private func saveEntry() {
        viewModel.addEntry(
            title: title,
            content: content,
            mood: selectedMood,
            tags: tags
        )
        dismiss()
    }
}

#Preview {
    let streakVM = StreakViewModel()

    NavigationStack {
        PromptJournalEditorView(
            viewModel: JournalEntryViewModel(streakViewModel: streakVM),
            prompt: "What feels most present for you right now, and what do you need in this moment?",
            selectedMood: Mood(
                type: .calm,
                emoji: "😌",
                label: "Calm"
            )
        )
    }
}
