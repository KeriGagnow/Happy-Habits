//
//  Habit.swift
//  Happy Habits
//
//  Created by Keri on 6/7/26.
//
//Created as an class to reset daily habits and marking habits as done

import Foundation

import SwiftData

@Model
final class Habit{
    var name: String
    var isCompleted: Bool = false
    var lastCompletedDate: Date? = nil
    
    init(name: String){
        self.name = name
        self.isCompleted = false
        self.lastCompletedDate = nil
    }
    //check if habits should reset for new date
    func shouldResetForNewDay() -> Bool {
        guard let lastDate = lastCompletedDate else {
            return false
        }
        let calendar = Calendar.current
        let isNewDay = !calendar.isDateInToday(lastDate)
        return isNewDay && isCompleted
    }
    //reset the habit for the day
    func resetForNewDay() {
        if shouldResetForNewDay() {
            isCompleted = false
        }
    }
    //mark habit as completed for today
    func markCompleted(){
        isCompleted = true
        lastCompletedDate = Date()
    }
}

