//
//  HabitModel.swift
//  MicroHabits Watch App
//
//  Created by Muna Onuorah on 11/20/25.
//

import Foundation
import SwiftUI

enum HabitType: String, Codable, CaseIterable, Identifiable {
    case drinkWater
    case move
    case breathe
    
    var id: String {
        return self.rawValue
    }
    
    var label: String {
        switch self {
        case .drinkWater:
            return "Water"
        case .move:
            return "Move"
        case .breathe:
            return "Breathe"
        }
    }
    
    var icon: String {
        switch self {
        case .drinkWater:
            return "drop.fill"
        case .move:
            return "figure.walk"
        case .breathe:
            return "wind"
        }
    }
    
    var color: Color {
        switch self {
        case .drinkWater:
            return .blue
        case .move:
            return .green
        case .breathe:
            return .purple
        }
    }
}

struct HabitEvent: Identifiable, Codable {
    let id: UUID
    let type: HabitType
    let timestamp: Date
    
    init(type: HabitType, timestamp: Date = Date()) {
        self.id = UUID()
        self.type = type
        self.timestamp = timestamp
    }
}
