//
//  TodayHabitBarsView.swift
//  MicroHabits Watch App
//
//  Created by Muna Onuorah on 11/20/25.
//

import SwiftUI

struct TodayHabitBarsView: View {
    let countsByHabit: [HabitType: Int]
    
    var maxCount: Int {
        let counts = countsByHabit.values
        return max(counts.max() ?? 1, 1)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 8) {
                ForEach(HabitType.allCases) { habitType in
                    HabitBarRow(
                        habitType: habitType,
                        count: countsByHabit[habitType] ?? 0,
                        maxCount: maxCount,
                        availableWidth: geometry.size.width
                    )
                }
            }
            .padding(.vertical, 4)
        }
    }
}

struct HabitBarRow: View {
    let habitType: HabitType
    let count: Int
    let maxCount: Int
    let availableWidth: CGFloat
    
    var barWidth: CGFloat {
        let labelWidth: CGFloat = 80
        let maxBarWidth = availableWidth - labelWidth
        
        if count == 0 {
            return 2
        }
        
        let ratio = CGFloat(count) / CGFloat(maxCount)
        return max(2, ratio * maxBarWidth)
    }
    
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: habitType.icon)
                    .font(.caption2)
                    .foregroundColor(habitType.color)
                    .frame(width: 16)
                
                Text(habitType.label)
                    .font(.caption2)
                    .frame(width: 40, alignment: .leading)
            }
            .frame(width: 60, alignment: .leading)
            
            RoundedRectangle(cornerRadius: 3)
                .fill(habitType.color)
                .frame(width: barWidth, height: 16)
            
            Text("\(count)")
                .font(.caption2)
                .foregroundColor(.secondary)
                .frame(width: 16, alignment: .trailing)
        }
    }
}

#Preview {
    let sampleCounts: [HabitType: Int] = [
        .drinkWater: 5,
        .move: 3,
        .breathe: 7
    ]
    
    TodayHabitBarsView(countsByHabit: sampleCounts)
        .frame(height: 100)
        .padding()
}
