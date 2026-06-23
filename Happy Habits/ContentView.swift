/* Happy Habits By Keri Gagnow
 github.com/KeriGagnow
 Created on May 31st, 2026 ; Edited on June 7th, 2026*/

// Import SwiftUI, SwiftData and Foundation

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var store: HabitStore?
    @State private var showAddHabitSheet = false
    @State private var newHabitName = ""
    
    var body: some View {
        NavigationView {
            if let store = store {
                List {
                    ForEach(store.habits) { habit in
                        HStack {
                            Text(habit.name)
                            Spacer()
                            Button(action: {
                                store.toggleHabit(habit)
                            }) {
                                Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(habit.isCompleted ? .green : .gray)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            store.removeHabit(store.habits[index])
                        }
                    }
                }
                .navigationTitle("Daily Habits")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showAddHabitSheet = true }) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
                .sheet(isPresented: $showAddHabitSheet) {
                    AddHabitSheet(isPresented: $showAddHabitSheet) { habitName in
                        store.addHabit(name: habitName)
                    }
                }
            } else {
                ProgressView("Loading habits...")
                    .onAppear {
                        store = HabitStore(modelContext: modelContext)
                    }
            }
        }
    }
}

/// Simple sheet for adding new habits
struct AddHabitSheet: View {
    @Binding var isPresented: Bool
    var onAdd: (String) -> Void
    @State private var habitName = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Habit Name") {
                    TextField("Enter habit name", text: $habitName)
                }
            }
            .navigationTitle("Add New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        if !habitName.trimmingCharacters(in: .whitespaces).isEmpty {
                            onAdd(habitName)
                            isPresented = false
                        }
                    }
                    .disabled(habitName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
