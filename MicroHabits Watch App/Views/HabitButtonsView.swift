//
//  HabitButtonsView.swift
//  MicroHabits Watch App
//
//  Created by Muna Onuorah on 11/20/25.
//


import SwiftUI

struct HabitButtonsView: View {
    @EnvironmentObject var store: HabitStore
    @Binding var lastLoggedHabit: HabitType?
    @Binding var showConfirmation: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(HabitType.allCases) { habitType in
                HabitButton(
                    habitType: habitType,
                    lastLoggedHabit: $lastLoggedHabit,
                    showConfirmation: $showConfirmation
                )
            }
        }
        .padding(.vertical, 4)
    }
}

struct HabitButton: View {
    let habitType: HabitType
    @EnvironmentObject var store: HabitStore
    @Binding var lastLoggedHabit: HabitType?
    @Binding var showConfirmation: Bool
    
    // Extra Credit: Show streak badge if logged today
    var hasLoggedToday: Bool {
        store.eventsToday.contains { $0.type == habitType }
    }
    
    var body: some View {
        Button(action: {
            store.log(habitType)
            lastLoggedHabit = habitType
            showConfirmation = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if lastLoggedHabit == habitType {
                    showConfirmation = false
                }
            }
        }) {
            VStack(spacing: 4) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: habitType.icon)
                        .font(.title2)
                        .foregroundColor(habitType.color)
                    
                    if hasLoggedToday {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption2)
                            .foregroundColor(.green)
                            .background(
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 10, height: 10)
                            )
                            .offset(x: 8, y: -8)
                    }
                }
                
                Text(habitType.label)
                    .font(.caption2)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(habitType.color.opacity(0.15))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(habitType.color.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    HabitButtonsView(
        lastLoggedHabit: .constant(nil),
        showConfirmation: .constant(false)
    )
    .environmentObject(HabitStore())
    .padding()
}
