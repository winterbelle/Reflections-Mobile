//
//  JournalEditorView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//
import SwiftUI

struct JournalEditorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: JournalEntryViewModel
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedMood: Mood?
    @State private var tags: [String] = []
    @State private var newTag: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TextField("Entry Title", text: $title)
                    .font(.title2)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                Text("Select Mood")
                    .font(.headline)
                
                MoodSelectorView(selectedMood: $selectedMood)
                
                Text("Tags")
                    .font(.headline)
                
                HStack {
                    TextField("Add Tag", text: $newTag)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.none)
                    
                    Button("Add") {
                        if !newTag.isEmpty {
                            tags.append(newTag)
                            newTag = ""
                        }
                    }
                }
                
                HStack {
                    tagList
                }
                
                ZStack(alignment: .topLeading) {

                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemBackground))

                    if content.isEmpty {
                        Text("Share your thoughts here…")
                            .foregroundColor(.gray)
                            .padding(.top, 12)
                            .padding(.leading, 8)
                            .allowsHitTesting(false)
                    }

                    TextEditor(text: $content)
                        .padding(8)
                        .frame(minHeight: 200, maxHeight: 200, alignment: .topLeading)
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
        let columns = [
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5),
            GridItem(.flexible(), spacing: 5)
        ]

        return LazyVGrid(columns: columns, alignment: .leading, spacing: 5) {
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
        viewModel.addEntry(title: title, content: content, mood: selectedMood, tags: tags)
        dismiss()
    }
}

#Preview {
    let streakVM = StreakViewModel()

    NavigationStack {
        JournalEditorView(
            viewModel: JournalEntryViewModel(streakViewModel: streakVM)
        )
    }
}
