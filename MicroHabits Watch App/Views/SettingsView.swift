//
//  SettingsView.swift
//  MicroHabits Watch App
//
//  Created by Muna Onuorah on 11/20/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("recentLimit") var recentLimit: Int = 5
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Display")
                        .font(.headline)
                    
                    Text("Recent events to show:")
                        .font(.body)
                    
                    HStack {
                        Stepper(
                            value: $recentLimit,
                            in: 3...10,
                            step: 1
                        ) {
                            Text("\(recentLimit)")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .padding(.vertical, 4)
            }
            
            Section {
                VStack(alignment: .leading, spacing: 4) {
                    Text("About")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("This controls how many recent habit events are shown in the Today list on the main screen.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
