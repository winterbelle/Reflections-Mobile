//
//  SmileCarouselView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/9/25.
//

import SwiftUI
import PhotosUI

struct SmileCarouselView: View {
    @StateObject private var viewModel = SmileCarouselViewModel()
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentIndex = 0
    @State private var timer: Timer?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Smiles")
                    .font(.system(size: 16, weight: .black))

                Spacer()

                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundColor(Color(hex: "#D96E54"))
                }
            }
            .frame(width: 170)

            cardBase {
                if viewModel.photos.isEmpty {
                    Text("Add moments that made you smile")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    TabView(selection: $currentIndex) {
                        ForEach(Array(viewModel.photos.enumerated()), id: \.element.id) { index, photo in
                            if let uiImage = UIImage(data: photo.imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .clipped()
                                    .tag(index)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                }
            }
        }
        .onAppear {
                    startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .onChange(of: viewModel.photos.count) { _ in
            currentIndex = 0
            startTimer()
        }
        .onChange(of: selectedItem) { newItem in
            guard let newItem else { return }

            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    viewModel.addImage(image)
                }
            }
        }
    }
}

private extension SmileCarouselView {
    func cardBase<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .overlay(
                content()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
            )
            .frame(width: 170, height: 170)
    }
}

private extension SmileCarouselView {

    func startTimer() {
        stopTimer()

        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            guard !viewModel.photos.isEmpty else { return }

            withAnimation {
                currentIndex = (currentIndex + 1) % viewModel.photos.count
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    SmileCarouselView()
        .padding()
}
