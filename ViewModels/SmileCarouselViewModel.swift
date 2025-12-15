//
//  SmileCarouselViewModel.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//

import Foundation
import UIKit

class SmileCarouselViewModel: ObservableObject {
    @Published var photos: [SmilePhoto] = []

    private let saveKey = "smile_photos"

    init() {
        load()
    }

    func addImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        photos.append(SmilePhoto(imageData: data))
        save()
    }

    func delete(_ photo: SmilePhoto) {
        photos.removeAll { $0.id == photo.id }
        save()
    }

    private func save() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(photos) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else { return }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([SmilePhoto].self, from: data) {
            photos = decoded
        }
    }
}
