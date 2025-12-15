//
//  Quote.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//
import Foundation

struct QuoteOfTheDay: Decodable {
    let quote: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case quote = "q"
        case author = "a"
    }
}

