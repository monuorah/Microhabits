//
//  MicroHabitsApp.swift
//  MicroHabits Watch App
//
//  Created by Muna Onuorah on 11/20/25.
//

import SwiftUI

@main
struct MicroHabits_Watch_AppApp: App {
    @StateObject private var store = HabitStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(store)
            }
        }
    }
}
