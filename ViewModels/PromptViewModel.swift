//
//  PromptViewModel.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//
import Foundation

@MainActor
final class PromptViewModel: ObservableObject {

    @Published var prompt: String = ""
    @Published var isLoading = false

    private let service = AIService()

    func fetchPrompt(mood: MoodType?) {
        print("🧠 fetchPrompt called with mood:", mood?.rawValue ?? "nil")
        isLoading = true
        prompt = ""

        service.generatePrompt(mood: mood) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let text):
                    self?.prompt = text
                case .failure:
                    self?.prompt = "Take a quiet moment to reflect."
                }
            }
        }
    }
}
