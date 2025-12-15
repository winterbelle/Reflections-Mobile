//
//  JournalEntryViewModel.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//

import Foundation
import SwiftUI

class JournalEntryViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []
    
    private let saveKey = "journal_entries"
    private let streakViewModel: StreakViewModel

        init(streakViewModel: StreakViewModel = StreakViewModel()) {
            self.streakViewModel = streakViewModel
            loadEntries()
        }
    
    //full CRUD for creating, loading, updating, and deleting entries
    //also allows for toggling for favorite
    //Storage using JSON
    func addEntry(title: String, content: String, mood: Mood?, tags: [String], hasPrompt: Bool = false) {
        let newEntry = JournalEntry(
            title: title,
            content: content,
            mood: mood,
            tags: tags,
            hasPrompt: hasPrompt
        )

        entries.insert(newEntry, at: 0)
        saveEntries()
        streakViewModel.recordJournalEntry()
    }

    
    func updateEntry(_ entry: JournalEntry, title: String, content: String, mood: Mood?, tags: [String]) {
        if let index = entries.firstIndex(where: {$0.id == entry.id}) {
            var updated = entry
            updated.title = title
            updated.content = content
            updated.mood = mood
            updated.tags = tags
            updated.updatedAt = Date()
            
            entries[index] = updated
            saveEntries()
        }
    }
    
    func deleteEntry(_ entry: JournalEntry) {
        entries.removeAll{ $0.id == entry.id }
        saveEntries()
    }
    
    func toggleFavorite(_ entry: JournalEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id}) {
            entries[index].isFavorite.toggle()
            saveEntries()
        }
    }
    
    func saveEntries() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        if let savedData = try? encoder.encode(entries) {
            UserDefaults.standard.set(savedData, forKey: saveKey)
        }
    }
    
    func loadEntries() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else { return }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        if let loadedEntries = try? decoder.decode([JournalEntry].self, from: data) {
            self.entries = loadedEntries
        }
    }
    
                            
}


