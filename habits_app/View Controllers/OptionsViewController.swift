import UIKit

class OptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Options"

        setupTableView()

        // ✅ Add "+" and "-" buttons
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabitTapped))
        addButton.tintColor = .white

        let removeButton = UIBarButtonItem(title: "−", style: .plain, target: self, action: #selector(toggleEditingMode))
        removeButton.tintColor = .white  // ✅ Ensure visibility on black background

        navigationItem.rightBarButtonItems = [addButton, removeButton]
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "OptionsCell")

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func addHabitTapped() {
        DataManager.shared.addHabit(title: "New Habit", value: "$0", progress: 0.5, leftPercentage: "50%", rightPercentage: "50%")
        tableView.reloadData()  // ✅ Refresh UI after adding
    }
    
    @objc private func toggleEditingMode() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    // ✅ TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.habits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as? OptionsTableViewCell else {
            return UITableViewCell()
        }

        let habit = DataManager.shared.habits[indexPath.row]
        cell.configure(title: habit.title, value: habit.value, progress: habit.progress, leftPercent: habit.leftPercentage, rightPercent: habit.rightPercentage)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    // ✅ Enable row editing (for delete button)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // ✅ Handle habit deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleting habit at index: \(indexPath.row)")  // ✅ Debug log
            DataManager.shared.removeHabit(at: indexPath.row)

            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .fade)
            }, completion: { _ in
                tableView.reloadData()  // ✅ Ensure full update
            })
        }
    }
}
