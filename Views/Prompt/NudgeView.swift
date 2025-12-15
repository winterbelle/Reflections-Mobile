//
//  NudgeView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/12/25.
//

import SwiftUI

struct NudgeView: View {
    let mood: Mood?
    let journalViewModel: JournalEntryViewModel

    @StateObject private var viewModel = PromptViewModel()
    @State private var isFlipped = false
    @State private var showJournalEditor = false

    private let fallbackMood = Mood(
        type: .calm,
        emoji: "😌",
        label: "Calm"
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)

                Text("Need a nudge?")
                    .font(.system(size: 16, weight: .black))
            }
            .frame(width: 170, alignment: .leading)

            ZStack {
                if isFlipped {
                    backView
                } else {
                    frontView
                }
            }
            .frame(width: 170, height: 170)
            .rotation3DEffect(
                .degrees(isFlipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .animation(.spring(response: 0.45, dampingFraction: 0.8), value: isFlipped)
        }
        .navigationDestination(isPresented: $showJournalEditor) {
            PromptJournalEditorView(
                viewModel: journalViewModel,
                prompt: viewModel.prompt,
                selectedMood: mood ?? fallbackMood
            )
        }
    }

}


private extension NudgeView {
    var frontView: some View {
        cardBase {
            VStack(alignment: .leading, spacing: 8) {
                Text("Try a reflection prompt curated for today's mood.")
                    .font(.system(size: 20))
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                HStack {
                    Spacer()
                    Button("Show Prompt") {
                        print("🔥 SHOW PROMPT BUTTON TAPPED")
                        
                        withAnimation {
                            isFlipped = true
                        }
                        
                        viewModel.fetchPrompt(mood: mood?.type)
                    }
                    .nudgeButtonStyle()
                    Spacer()
                }

            }
        }
    }
}


private extension NudgeView {
    var backView: some View {
        cardBase {
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Spacer()
                    Button {
                        flipBack()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.red)
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView("Thinking…")
                } else if !viewModel.prompt.isEmpty {
                    ScrollView {
                        Text(viewModel.prompt)
                            .font(.system(size: 14))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxHeight: 80)
                }
                
                HStack {
                    Spacer()
                    Button("Reflect on this") {
                        showJournalEditor = true
                    }
                    .nudgeButtonStyle()
                    .padding(.top, 6)
                    Spacer()
                }
            }
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }
}


private extension NudgeView {

    func flipBack() {
        withAnimation {
            isFlipped = false
        }
        viewModel.prompt = ""
    }

    func cardBase<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
            )
            .overlay(content().padding(12), alignment: .topLeading)
    }
}

private extension View {
    func nudgeButtonStyle() -> some View {
        self
            .font(.system(size: 16, weight: .semibold))
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(Color(hex: "#D96E54"))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}


#Preview {
    NavigationStack {
        let streakVM = StreakViewModel()
        let journalVM = JournalEntryViewModel(streakViewModel: streakVM)

        NudgeView(
            mood: Mood(
                type: .calm,
                emoji: "😌",
                label: "Calm"
            ),
            journalViewModel: journalVM
        )
        .padding()
    }
}
