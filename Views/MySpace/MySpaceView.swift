//
//  MySpaceView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//

import SwiftUI

struct MySpaceView: View {
    @State private var currentPage = 0
    @StateObject private var streakViewModel: StreakViewModel
    @StateObject private var journalViewModel: JournalEntryViewModel
    @StateObject private var moodViewModel = MoodViewModel()
    
    init() {
        let streakVM = StreakViewModel()
        _journalViewModel = StateObject(
            wrappedValue: JournalEntryViewModel(streakViewModel: streakVM)
        )
        _streakViewModel = StateObject(wrappedValue: streakVM)
    }



    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("My Space")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink {
                        JournalEditorView(viewModel: journalViewModel)
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 28))
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.horizontal)
                
                TabView(selection: $currentPage) {
                    IntroCardView()
                        .tag(0)
                    
                    QuoteCardView(viewModel: QuoteViewModel())
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // hide built-in dots
                .frame(height: 180)
                .padding(.horizontal)
                
                //custom dots
                HStack(spacing: 8) {
                    Circle()
                        .fill(currentPage == 0 ? Color.black : Color.gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                    
                    Circle()
                        .fill(currentPage == 1 ? Color.black : Color.gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                NavigationLink {
                    StreakDetailView(viewModel: streakViewModel)
                } label: {
                    StreakCardView(viewModel: streakViewModel)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .zIndex(1)
                .padding(.top, 12)
                .padding(.horizontal)
                
                Text("How are you feeling today?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                MoodSelectorView(selectedMood: $moodViewModel.selectedMood)
                    .padding(.top, 5)
                    .padding(.horizontal)
                
                
                HStack {
                    
                    NudgeView(
                        mood: moodViewModel.selectedMood,
                        journalViewModel: journalViewModel
                    )

                    
                    
                    Spacer()
                    
                    SmileCarouselView()
                    
                }
                .padding(.top, 15)
                .padding(.horizontal)
                
                Text("My Entries")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top, 20)

                LazyVStack(spacing: 12) {
                    ForEach(journalViewModel.entries) { entry in
                        EntryRowView(entry: entry) {
                            journalViewModel.deleteEntry(entry)
                        }
                    }
                }
                .padding(.horizontal)

                
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    NavigationStack {
        MySpaceView()
    }
}

