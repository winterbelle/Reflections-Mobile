//
//  SmileImage.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//

import Foundation

struct SmilePhoto: Identifiable, Codable {
    let id: UUID
    let imageData: Data

    init(imageData: Data) {
        self.id = UUID()
        self.imageData = imageData
    }
}
