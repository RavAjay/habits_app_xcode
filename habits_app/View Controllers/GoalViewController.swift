//
//  GoalViewController.swift
//  habits_app
//
//  Created by Home PC on 4/3/25.
//

import UIKit

class GoalViewController: UIViewController {

    var habit: Habit?

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = habit?.title ?? "Goal"
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        // Optional: Add a gradient background to the view for a more modern look
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        setupCalendarGridView()
    }

    private func setupCalendarGridView() {
        let gridView = UIView()
        gridView.backgroundColor = .white//UIColor(white: 0.15, alpha: 1)
        gridView.layer.borderWidth = 1
        gridView.layer.borderColor = UIColor.lightGray.cgColor
        gridView.layer.cornerRadius = 12
        gridView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(gridView)

        NSLayoutConstraint.activate([
            gridView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            gridView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            gridView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            gridView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            gridView.heightAnchor.constraint(equalToConstant: 400) // increased height
        ])

        let gridStackView = UIStackView()
        gridStackView.axis = .vertical
        gridStackView.spacing = 10 // Increase spacing between elements
        gridStackView.translatesAutoresizingMaskIntoConstraints = false
        gridView.addSubview(gridStackView)

        NSLayoutConstraint.activate([
            gridStackView.topAnchor.constraint(equalTo: gridView.topAnchor, constant: 10),
            gridStackView.leadingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: 10),
            gridStackView.trailingAnchor.constraint(equalTo: gridView.trailingAnchor, constant: -10),
            gridStackView.bottomAnchor.constraint(equalTo: gridView.bottomAnchor, constant: -10)
        ])

        // Insert goal title label above the calendar
        let goalLabel = UILabel()
        goalLabel.text = "Goal" // Removed "Tracking: " prefix
        goalLabel.textColor = .darkGray
        goalLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold) // Use a similar font
        goalLabel.textAlignment = .center
        goalLabel.layer.masksToBounds = true
        goalLabel.layer.cornerRadius = 10 // Rounded corners for a card-like effect
        goalLabel.backgroundColor = UIColor(white: 0.95, alpha: 1) // Soft background color
        goalLabel.layer.shadowColor = UIColor.black.cgColor
        goalLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        goalLabel.layer.shadowOpacity = 0.2
        goalLabel.layer.shadowRadius = 4 // Subtle shadow to make the label stand out
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        gridStackView.addArrangedSubview(goalLabel)

        let today = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        let headerLabel = UILabel()
        headerLabel.text = dateFormatter.string(from: today)
        headerLabel.textColor = .darkGray // Darker color for better contrast
        headerLabel.font = UIFont.boldSystemFont(ofSize: 22) // Increase size
        headerLabel.textAlignment = .center
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        gridStackView.addArrangedSubview(headerLabel)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: gridStackView.topAnchor, constant: 10)
        ])

        let components = calendar.dateComponents([.year, .month], from: today)
        guard let firstDayOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else { return }

        var dayIndex = calendar.component(.weekday, from: firstDayOfMonth) - 1

        let weekStack = UIStackView()
        weekStack.axis = .horizontal
        weekStack.distribution = .fillEqually
        weekStack.spacing = 5
        gridStackView.addArrangedSubview(weekStack)

        let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        for day in days {
            let label = UILabel()
            label.text = day
            label.textAlignment = .center
            label.textColor = .black
            weekStack.addArrangedSubview(label)
        }

        // Add a separator bar under the weekday labels
        let separatorBar = UIView()
        separatorBar.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        separatorBar.translatesAutoresizingMaskIntoConstraints = false
        gridStackView.addArrangedSubview(separatorBar)

        NSLayoutConstraint.activate([
            separatorBar.heightAnchor.constraint(equalToConstant: 1)
        ])

        var currentWeekStack = UIStackView()
        currentWeekStack.axis = .horizontal
        currentWeekStack.distribution = .fillEqually
        currentWeekStack.spacing = 5
        gridStackView.addArrangedSubview(currentWeekStack)

        for _ in 0..<dayIndex {
            let emptyLabel = UILabel()
            currentWeekStack.addArrangedSubview(emptyLabel)
        }

        for day in range {
            if dayIndex == 7 {
                dayIndex = 0
                currentWeekStack = UIStackView()
                currentWeekStack.axis = .horizontal
                currentWeekStack.distribution = .fillEqually
                currentWeekStack.spacing = 5
                gridStackView.addArrangedSubview(currentWeekStack)
            }

            let dayLabel = UILabel()
            dayLabel.text = "\(day)"
            dayLabel.textAlignment = .center
            dayLabel.textColor = .black
            dayLabel.layer.cornerRadius = 10
            dayLabel.layer.masksToBounds = true
            dayLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            dayLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium) // increased font size
            dayLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true // increased size of day labels

            currentWeekStack.addArrangedSubview(dayLabel)
            dayIndex += 1
        }
    }

    private func setupHabitStats() {
        let habitStatsView = UIView()
        habitStatsView.backgroundColor = UIColor(white: 0.15, alpha: 1)
        habitStatsView.layer.cornerRadius = 12
        habitStatsView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(habitStatsView)

        NSLayoutConstraint.activate([
            habitStatsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitStatsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            habitStatsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            habitStatsView.heightAnchor.constraint(equalToConstant: 100)
        ])

        let progressLabel = UILabel()
        progressLabel.text = "6.5"
        progressLabel.textColor = .white
        progressLabel.font = UIFont.boldSystemFont(ofSize: 24)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        habitStatsView.addSubview(progressLabel)

        NSLayoutConstraint.activate([
            progressLabel.centerYAnchor.constraint(equalTo: habitStatsView.centerYAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: habitStatsView.leadingAnchor, constant: 16)
        ])
    }
}
