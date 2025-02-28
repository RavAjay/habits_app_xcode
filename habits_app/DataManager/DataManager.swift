import Foundation

class DataManager {
    static let shared = DataManager() // ✅ Singleton instance

    // Habit Data Structure
    struct Habit {
        let title: String
        var value: String
        var progress: Float
        var leftPercentage: String
        var rightPercentage: String
    }

    // Array to Store Habits
    private(set) var habits: [Habit] = [
        Habit(title: "Doctor's visit", value: "$120", progress: 0.9, leftPercentage: "90%", rightPercentage: "10%"),
        Habit(title: "Gym membership", value: "$50", progress: 0.7, leftPercentage: "70%", rightPercentage: "30%"),
        Habit(title: "Reading", value: "$0", progress: 0.95, leftPercentage: "95%", rightPercentage: "5%")
    ]

    // MARK: - CRUD Operations
    func addHabit(title: String, value: String, progress: Float, leftPercentage: String, rightPercentage: String) {
        let newHabit = Habit(title: title, value: value, progress: progress, leftPercentage: leftPercentage, rightPercentage: rightPercentage)
        habits.append(newHabit)
    }

    func removeHabit(at index: Int) {
        guard index < habits.count else { return }
        habits.remove(at: index)
    }

    func updateHabit(at index: Int, value: String, progress: Float, leftPercentage: String, rightPercentage: String) {
        guard index < habits.count else { return }
        habits[index].value = value
        habits[index].progress = progress
        habits[index].leftPercentage = leftPercentage
        habits[index].rightPercentage = rightPercentage
    }
}
