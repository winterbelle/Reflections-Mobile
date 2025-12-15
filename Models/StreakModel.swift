//
//  StreakModel.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//
import Foundation

struct Streak: Identifiable, Codable {
    var id = UUID()
    var currentStreak: Int
    var longestStreak: Int
    var lastEntryDate: Date?    
    
    init(
        currentStreak: Int = 0,
        longestStreak: Int = 0,
        lastEntryDate: Date? = nil
    ) {
        self.currentStreak = currentStreak
        self.longestStreak = longestStreak
        self.lastEntryDate = lastEntryDate
    }
}


