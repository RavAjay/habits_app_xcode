//
//  GoalViewController.swift
//  habits_app
//
//  Created by Home PC on 4/3/25.
//

import UIKit

class GoalViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Goal"
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

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
            gridView.heightAnchor.constraint(equalToConstant: 300)
        ])

        let gridStackView = UIStackView()
        gridStackView.axis = .vertical
        gridStackView.spacing = 5
        gridStackView.translatesAutoresizingMaskIntoConstraints = false
        gridView.addSubview(gridStackView)

        NSLayoutConstraint.activate([
            gridStackView.topAnchor.constraint(equalTo: gridView.topAnchor, constant: 10),
            gridStackView.leadingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: 10),
            gridStackView.trailingAnchor.constraint(equalTo: gridView.trailingAnchor, constant: -10),
            gridStackView.bottomAnchor.constraint(equalTo: gridView.bottomAnchor, constant: -10)
        ])

        let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        let firstDayOfMonth = calendar.date(from: components)!
        let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!

        var dayIndex = calendar.component(.weekday, from: firstDayOfMonth) - 1

        let weekStack = UIStackView()
        weekStack.axis = .horizontal
        weekStack.distribution = .fillEqually
        weekStack.spacing = 5
        gridStackView.addArrangedSubview(weekStack)

        for day in days {
            let label = UILabel()
            label.text = day
            label.textAlignment = .center
            label.textColor = .black
            weekStack.addArrangedSubview(label)
        }

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
