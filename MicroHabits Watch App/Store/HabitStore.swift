//
//  HabitStore.swift
//  MicroHabits Watch App
//
//  Created by Muna Onuorah on 11/20/25.
//

import Foundation
import SwiftUI
import Combine

class HabitStore: ObservableObject {
    @Published var events: [HabitEvent] = []
    
    private let fileName = "habits.json"
    
    init() {
        load()
    }
    
    var eventsToday: [HabitEvent] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return events.filter { event in
            calendar.isDate(event.timestamp, inSameDayAs: Date())
        }
    }
    
    var countsByHabit: [HabitType: Int] {
        var counts: [HabitType: Int] = [:]
        
        for habitType in HabitType.allCases {
            counts[habitType] = 0
        }
        
        for event in eventsToday {
            counts[event.type, default: 0] += 1
        }
        
        return counts
    }
    
    func log(_ type: HabitType) {
        let newEvent = HabitEvent(type: type, timestamp: Date())
        events.append(newEvent)
        save()
    }
    
    private func fileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(events)
            try data.write(to: fileURL(), options: .atomic )
        } catch {
            print("Error saving habits: \(error.localizedDescription)")
        }
    }
    
    func load() {
        let url = fileURL()
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            events = try JSONDecoder().decode([HabitEvent].self, from: data)
        } catch {
            print("Error loading habits: \(error.localizedDescription)")
        }
    }
}
