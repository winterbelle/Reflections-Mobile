//
//  AIService.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/13/25.
//

import Foundation

final class AIService {

    private let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!

    func generatePrompt(
        mood: MoodType?,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        print("🚀 OpenAI generatePrompt CALLED")

        let userPrompt: String
        if let mood {
            userPrompt = "Give a gentle journaling prompt for a parent who feels \(mood.rawValue). Ask one reflective question under two sentences."
        } else {
            userPrompt = "Give a gentle journaling prompt for a parent. Ask one reflective question under two sentences."
        }

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "user", "content": userPrompt]
            ],
            "temperature": 0.7
        ]

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, error in

            if let error {
                completion(.failure(error))
                return
            }

            guard let data else {
                completion(.failure(NSError(domain: "NoData", code: 0)))
                return
            }

            if let raw = String(data: data, encoding: .utf8) {
                print("OPENAI RAW RESPONSE:\n\(raw)")
            }

            guard
                let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let choices = json["choices"] as? [[String: Any]],
                let message = choices.first?["message"] as? [String: Any],
                let content = message["content"] as? String
            else {
                completion(.failure(NSError(domain: "ParseError", code: 0)))
                return
            }

            completion(.success(content.trimmingCharacters(in: .whitespacesAndNewlines)))
        }
        .resume()
    }

    private var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "OPENAI_API_KEY") as? String ?? ""
    }
}
