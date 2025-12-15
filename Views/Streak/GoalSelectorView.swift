//
//  GoalSelectorView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/11/25.
//

import SwiftUI

struct GoalSelectorView: View {
    @ObservedObject var viewModel: StreakViewModel
    
    let possibleGoals = [7, 10, 14, 21, 30]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Choose Your Streak Goal")
                .font(.title2)
                .bold()

            ForEach(possibleGoals, id: \.self) { goal in
                Button(action: {
                    viewModel.updateGoal(to: goal)
                }) {
                    HStack {
                        Text("\(goal)-day goal")
                        Spacer()

                        if viewModel.goal == goal {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Streak Goal")
    }
}

#Preview {
    GoalSelectorView(viewModel: StreakViewModel())
}

