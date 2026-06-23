//
//  HabitStore.swift
//  Happy Habits
//
//  Created by Keri on 6/7/26.
//
//Stores and delete habits as needed

import Foundation

import SwiftData

@MainActor
class HabitStore {
    @Published var habits: [Habit] = []
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext){
        self.modelContext = modelContext
        loadHabits()
    }
    //loads stored habits
    func loadHabits(){
        let descriptor = FetchDescriptor<Habit>()
        do {
            habits = try modelContext.fetch(descriptor)
            resetForNewDay()
            
        } catch {
            print("Error displaying habits :( : \(error)")
            habits = []
        }
    }
    //Adding a new habit
    func addHabit(name: String){
        let newHabit = Habit(name: name)
        habits.append(newHabit)
        modelContext.insert(newHabit)
        try? modelContext.save()
    }
    //remove a habit
    func removeHabit(_ habit: Habit){
        habits.removeAll {$0.id == habit.id}
        modelContext.delete(habit)
        try?modelContext.save()
    }
    //toogle for habit completion
    func toggleHabit(_ habit: Habit){
        habit.isCompleted.toggle()
        if habit.isCompleted{
            habit.lastCompletedDate = Date()
        }
        try? modelContext.save()
    }
    //Resets habits for next day
    private func resetForNewDay() {
        for habit in habits {
            habit.resetForNewDay()
        }
        try? modelContext.save()
    }
}

