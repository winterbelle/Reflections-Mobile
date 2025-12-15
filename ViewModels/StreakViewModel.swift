//
//  StreakViewModel.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//

import Foundation
import SwiftUI

class StreakViewModel: ObservableObject {
    @Published var streak: Streak
    @Published var activeJournalDates: [Date] = []
    @Published var goal: Int = 10   // default 10-day challenge, user can change
    
    @AppStorage("streakGoal") var savedGoal: Int = 10 {
        didSet { goal = savedGoal }
    }

    
    // Counter that triggers ConfettiCannon
    @Published var confettiTrigger: Int = 0
    
    init() {
        self.streak = Streak(
            currentStreak: 0,
            longestStreak: 0,
            lastEntryDate: nil
        )

        self.goal = savedGoal
    }

    
    func recordJournalEntry() {
        let calendar = Calendar.current
        let today = Date()
        
        // Save today's date into the activity list
        activeJournalDates.append(today)
        
        //  User wrote yesterday → streak continues, currentStreak increments by 1
        if let lastDate = streak.lastEntryDate,
           calendar.isDateInYesterday(lastDate) {
            
            streak.currentStreak += 1
            
        //No entry yesterday → streak resets to 1
        } else if streak.lastEntryDate == nil ||
                    !calendar.isDateInToday(streak.lastEntryDate!) {
            
            streak.currentStreak = 1
        }
        
        // Update longest streak
        streak.longestStreak = max(streak.longestStreak, streak.currentStreak)
        
        // Update last entry date
        streak.lastEntryDate = today
        
        
        //CONFETTI WHEN GOAL IS HIT
        if streak.currentStreak == goal {
            confettiTrigger += 1   // ConfettiCannon listens to this
        }
    }
    
    func updateGoal(to newGoal: Int) {
        goal = newGoal
        savedGoal = newGoal
    }
    
}
