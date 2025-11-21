//
//  TimeSinceLastView.swift
//  MicroHabits Watch App
//
//  Created by Muna Onuorah on 11/20/25.
//

import SwiftUI

struct TimeSinceLastView: View {
    let lastTimestamp: Date
    
    @State private var currentTime = Date()
    
    var timeSinceString: String {
        let interval = currentTime.timeIntervalSince(lastTimestamp)
        let minutes = Int(interval / 60)
        
        if minutes == 0 {
            return "Just now."
        } else if minutes == 1 {
            return "1 minute ago."
        } else {
            return "\(minutes) minutes ago."
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Last habit:")
                .font(.caption2)
                .foregroundColor(.secondary)
            
            Text(timeSinceString)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                currentTime = Date()
            }
        }
    }
}

#Preview {
    TimeSinceLastView(lastTimestamp: Date().addingTimeInterval(-120))
        .padding()
}
