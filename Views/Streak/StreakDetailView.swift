//
//  StreakDetailView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//

import SwiftUI

struct StreakDetailView: View {
    @ObservedObject var viewModel: StreakViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                
                // CURRENT STREAK SECTION
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Streak")
                        .font(.headline)
                    Text("\(viewModel.streak.currentStreak) days")
                        .font(.system(size: 40, weight: .bold))
                    Text(encouragementMessage)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Divider()
                
                // LONGEST STREAK SECTION
                VStack(alignment: .leading, spacing: 8) {
                    Text("Longest Streak")
                        .font(.headline)
                    Text("\(viewModel.streak.longestStreak) days")
                        .font(.title2)
                        .bold()
                }

                Divider()
                
                // GOAL SECTION — NEW 🔥🔥🔥
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Goal")
                        .font(.headline)
                    
                    Text("Current goal: \(viewModel.goal)-day streak")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    NavigationLink {
                        GoalSelectorView(viewModel: viewModel)
                    } label: {
                        Text("Change Goal")
                            .font(.subheadline)
                            .bold()
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                }
                
                Divider()
                
                // MINI CALENDAR HEATMAP
                Text("Activity Calendar")
                    .font(.headline)
                
                CalendarHeatmapView(activeDays: viewModel.activeJournalDates)
                    .frame(height: 100)
            }
            .padding()
        }
        .navigationTitle("Your Streaks")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var encouragementMessage: String {
        switch viewModel.streak.currentStreak {
        case 0...1: return "A fresh start. Keep going!"
        case 2...4: return "You're building momentum!"
        case 5...10: return "Consistency looks GOOD on you ✨"
        default: return "Lets Goooooooo 😤🔥"
        }
    }
}

#Preview {
    NavigationStack {
        StreakDetailView(viewModel: {
            let vm = StreakViewModel()
            vm.streak = Streak(currentStreak: 7, longestStreak: 10, lastEntryDate: Date())
            return vm
        }())
    }
}
