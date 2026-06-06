/* Happy Habits By Keri Gagnow
 github.com/KeriGagnow
 Created on May 31st, 2026 ; Edited on June 5th, 2026*/

// Import SwiftUI, SwiftData and Foundation

import SwiftUI

import SwiftData

import Foundation

//creating class Habit, which allows us to store data every time the app closes

@Model
final class Habit {
    var name: String
    var isCompleted: Bool = false
    
    init(name: String){
        self.name = name
        self.isCompleted = false
    }
}

// Creating our ContentView class, which displays the habits

struct ContentView: View{
    @State private var habits: [Habit] = [
        Habit(name: "Exercise for 40 minutes"),
        Habit(name: "Drink 32 oz of water"),
        Habit(name: "Mindful meditation for 10 minutes"),
        Habit(name: "Read a book for 25 minutes")
    ]
    var body: some View{
        NavigationView {
            List($habits) { $habit in
                HStack{
                    Text(habit.name)
                    Spacer()
                    Button(action: {
                        habit.isCompleted.toggle()
                    }) {
                        Image(systemName: habit.isCompleted ? "checkmark.circle.fill": "circle")
                    }
                    .onTapGesture {
                        habit.isCompleted.toggle()
                    }
                }
                .navigationTitle("Daily Habits")
            }
        }
    }
}

#Preview {
    ContentView()
}
