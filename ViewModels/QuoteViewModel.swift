//
//  QuoteViewModel.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//

import Foundation
import SwiftUI
import Combine

class QuoteViewModel: ObservableObject {
    @Published var quote: QuoteOfTheDay?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let quoteKey = "cachedQuoteText"
    private let authorKey = "cachedQuoteAuthor"
    private let dateKey = "cachedQuoteDate"
    private var midnightTimer: Timer?
    private var cancellable: AnyCancellable?
    
    init() {
        loadCachedQuoteOrFetch()
        scheduleMidnightRefresh()
        observeAppLifeCycle()
    }
    
    func loadCachedQuoteOrFetch() {
        let savedDate = UserDefaults.standard.string(forKey: dateKey)
        
        //today's date in YYYY-MM-DD format
        let today = Self.formattedDate(Date())
        
        if savedDate == today,
           let text = UserDefaults.standard.string(forKey: quoteKey),
           let author = UserDefaults.standard.string(forKey: authorKey) {
            quote = QuoteOfTheDay(quote: text, author: author)
        } else {
            fetchQuote()
        }
        
    }
    
    //refreshes quote at midnight if user leaves app open. 
    func scheduleMidnightRefresh() {
        midnightTimer?.invalidate()//cancels previous
        
        let fireDate = nextMidnight()
        let timeInterval = fireDate.timeIntervalSinceNow
        
        midnightTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) {
            _ in
            print("Its midnight! Lets display a new quote.")
            self.fetchQuote()
            self.scheduleMidnightRefresh() //schedule the next day refresh.
        }
    }
    
    //refreshes the quote if its a new day and user reopens app after closing the day before
    func observeAppLifeCycle() {
        cancellable = NotificationCenter.default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { _ in
                self.loadCachedQuoteOrFetch()
            }
    }
    
    func fetchQuote() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://zenquotes.io/api/today?apikey=\(Secrets.zenquotesAPIKey)") else {
            self.errorMessage = "Invalid API URL"
            return
        }

        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode([QuoteOfTheDay].self, from: data)
                    self.quote = decoded.first
                } catch {
                    self.errorMessage = "Failed to decode quote"
            
                }
        
            }
        }.resume()
    }
    
    private func saveQuoteToCache(_ quote: QuoteOfTheDay) {
        UserDefaults.standard.setValue(quote.quote, forKey: quoteKey)
        UserDefaults.standard.setValue(quote.author, forKey: authorKey)
        UserDefaults.standard.setValue(Self.formattedDate(Date()), forKey: dateKey)
    }
    
    static func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    //will refresh the quote at midnight
    private func nextMidnight() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = .current
        
        let now = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: now)!
        let midnight = calendar.startOfDay(for: tomorrow)
        
        return midnight
    }
}
