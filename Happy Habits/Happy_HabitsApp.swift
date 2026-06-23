//
//  Happy_HabitsApp.swift
//  Happy Habits
//
//  Created by Keri on 5/20/26.
//


import SwiftUI

import SwiftData

@main
struct Happy_HabitsApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Habit.self)
        } catch {
            fatalError("Cound not initalize: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup{
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
