//
//  IntroCardView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//

import SwiftUI

struct IntroCardView: View {
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 80, height: 80)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(style: StrokeStyle(lineWidth: 4))
                    )
                ZStack {
                    Image(systemName: "heart")
                        //I created a "helper" that allows me to use hex color or rgb to get the desired color I want.
                        .foregroundColor(Color(hex: "#D96E54"))
                        .font(.system(size: 60))
                    Image(systemName: "pencil")
                        .font(.system(size: 45))
                        .foregroundColor(Color(hex: "#5B6C94"))
                        .rotationEffect(.degrees(-5)) //tilts pencil
                        .offset(x: 15, y: -15) //moves it to the left and center
                        .scaleEffect(x: -1, y: 1) //mirror horizontally
                }
            }
            Text("Your private corner to reflect, track moods, and celebrate tiny wins.")
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 4))
        )
        
    }
}

#Preview {
    IntroCardView()
}

