//
//  CalendarHeatMapView.swift
//  reflections
//
//  Created by Blanca Altamirano on 12/10/25.
//
import SwiftUI

struct CalendarHeatmapView: View {
    let activeDays: [Date]
    let calendar = Calendar.current

    var body: some View {
        let last30 = (0..<30).map { calendar.date(byAdding: .day, value: -$0, to: Date())! }
        
        HStack(spacing: 4) {
            ForEach(last30.reversed(), id: \.self) { day in
                Rectangle()
                    .fill(activeDays.contains { calendar.isDate($0, inSameDayAs: day) }
                          ? Color.orange.opacity(0.8)
                          : Color.gray.opacity(0.2))
                    .frame(width: 9, height: 9)
                    .cornerRadius(2)
            }
        }
    }
}
