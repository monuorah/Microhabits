//
//  ContentView.swift
//  MicroHabits Watch App
//
//  Created by Muna Onuorah on 11/20/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var store: HabitStore
    @Environment(\.scenePhase) private var scenePhase
    
    @AppStorage("recentLimit") var recentLimit: Int = 5
    
    @State private var lastLoggedHabit: HabitType?
    @State private var showConfirmation: Bool = false
    @State private var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @State private var refreshTrigger = false
    
    var body: some View {
        List {
            // Status section - Extra Credit
            if let lastEvent = store.eventsToday.last {
                Section {
                    TimeSinceLastView(lastTimestamp: lastEvent.timestamp)
                }
            } else {
                Section {
                    Text("No habits yet.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            Section("Log Habits") {
                HabitButtonsView(
                    lastLoggedHabit: $lastLoggedHabit,
                    showConfirmation: $showConfirmation
                )
                .listRowBackground(Color.clear)
            }
            
            if !store.eventsToday.isEmpty {
                Section("Today Summary") {
                    TodayHabitBarsView(countsByHabit: store.countsByHabit)
                        .frame(height: 100)
                        .listRowBackground(Color.clear)
                }
            }
            
            Section("Today") {
                if store.eventsToday.isEmpty {
                    Text("No habits logged yet.\nTap a button above to get started.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                } else {
                    ForEach(Array(store.eventsToday.sorted(by: { $0.timestamp > $1.timestamp }).prefix(recentLimit))) { event in
                        HabitEventRow(event: event)
                    }
                }
            }
        }
        .navigationTitle("MicroHabits")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
            }
        }
        .onReceive(timer) { _ in
            refreshTrigger.toggle()
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                store.load()
                refreshTrigger.toggle()
            }
        }
    }
}

struct HabitEventRow: View {
    let event: HabitEvent
    
    var body: some View {
        HStack {
            Image(systemName: event.type.icon)
                .foregroundColor(event.type.color)
                .font(.title3)
            
            Text(event.type.label)
                .font(.body)
            
            Spacer()
            
            Text(event.timestamp, style: .time)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    ContentView()
        .environmentObject(HabitStore())
}
