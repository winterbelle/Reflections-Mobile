//
//  QuoteCardView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//

import SwiftUI

struct QuoteCardView: View {
    @StateObject var viewModel: QuoteViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if viewModel.isLoading {
                ProgressView()
            } else if let quote = viewModel.quote {
                Text("Quote of the Day")
                    .font(.headline)
                Text("“\(quote.quote)”")
                    .font(.system(size: 14))
                    .italic()
                Text("- \(quote.author)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                Text("No quote available")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 4))
        )
        .onAppear() {
            viewModel.fetchQuote() //displays the quote
        }
    }
}

#Preview {
    QuoteCardView(viewModel: QuoteViewModel())
}
