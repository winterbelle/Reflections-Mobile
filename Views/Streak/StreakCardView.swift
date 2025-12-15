//
//  StreakCardView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//

import SwiftUI
import ConfettiSwiftUI

struct StreakCardView: View {
    @ObservedObject var viewModel: StreakViewModel
    @State private var bounce = false
    
    var fireSize: CGFloat {
        switch viewModel.streak.currentStreak {
        case 0...3: return 24
        case 4...6: return 40
        case 7...13: return 70
        default: return 100
        }
    }

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            // Fire icon
            Text("🔥")
                .font(.system(size: fireSize))
                .scaleEffect(bounce ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.3).repeatForever(), value: bounce)

            VStack(alignment: .leading, spacing: 4) {
                
                // Streak number
                Text("\(viewModel.streak.currentStreak)-Day Streak")
                    .font(.largeTitle)
                    .bold()
                
                // Subtext
                Text("You've journaled \(viewModel.streak.currentStreak) days in a row")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Progress bar
                ProgressView(value: Double(viewModel.streak.currentStreak),
                             total: Double(viewModel.goal))
                    .tint(.orange)
                    .padding(.horizontal)
                    .padding(.top, 8)
            }
            .onAppear {
                bounce = true
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}



    #Preview {
        StreakCardView(
            viewModel: {
                let vm = StreakViewModel()
                vm.streak = Streak(currentStreak: 7, longestStreak: 10, lastEntryDate: Date())
                return vm
            }()
        )
        .padding()
    }

